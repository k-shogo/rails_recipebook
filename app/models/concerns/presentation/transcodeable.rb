class Presentation < ActiveRecord::Base
  module Transcodeable
    extend ActiveSupport::Concern

    def transcode
      if video?
        transcoder = AWS::ElasticTranscoder::Client.new(region: Settings.aws.region)
        jobs = Settings.aws.transcoder.presets.map{ |preset_id, name|
          options = {
            pipeline_id: Settings.aws.transcoder.pipeline_id,
            input: {
              key:          video.current_path,
              frame_rate:   'auto',
              resolution:   'auto',
              aspect_ratio: 'auto',
              interlaced:   'auto',
              container:    'auto'
            },
            outputs: [
              {
                key:               name,
                preset_id:         preset_id,
                rotate:            "auto",
                thumbnail_pattern: "{count}#{name}"
              }
            ],
            output_key_prefix: video.transcode_dir
          }
          transcoder.create_job(options)
        }
        Transcode.import jobs.map{|job| Transcode.aws_response_to_param(job).merge(presentation_id: id)}.map{|param| Transcode.new param}
        TranscodeCheckWorker.perform_async
      end
    end

  end
end
