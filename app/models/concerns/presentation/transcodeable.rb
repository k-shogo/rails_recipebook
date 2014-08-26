class Presentation < ActiveRecord::Base
  module Transcodeable
    extend ActiveSupport::Concern

    def transcode
      if video?
        transcoder = AWS::ElasticTranscoder::Client.new(region: Settings.aws.region)
        presets = {
          generic_360p_16_9: '1351620000001-000040',
          iPhone4:           '1351620000001-100010'
        }
        jobs = presets.map{ |preset_key, id|
          options = {
            pipeline_id: Settings.aws.transcoder_pipeline_id,
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
                key:               "#{preset_key}.mp4",
                preset_id:         id,
                rotate:            "auto",
                thumbnail_pattern: "{count}#{preset_key}"
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
