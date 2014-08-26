class Transcode < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :presentation
  enum status: {complete: 'complete', submitted: 'submitted', error: 'error'}

  def self.aws_response_to_param aws_response
    job = aws_response[:job]
    {
      job_id:            job[:id],
      arn:               job[:arn],
      pipeline_id:       job[:pipeline_id],
      input_key:         job[:input][:key],
      frame_rate:        job[:input][:frame_rate],
      resolution:        job[:input][:resolution],
      aspect_ratio:      job[:input][:aspect_ratio],
      interlaced:        job[:input][:interlaced],
      container:         job[:input][:container],
      output_key_prefix: job[:output_key_prefix],
      output_key:        job[:output][:key],
      thumbnail_pattern: job[:output][:thumbnail_pattern],
      rotate:            job[:output][:rotate],
      preset_id:         job[:output][:preset_id],
      duration:          job[:output][:duration],
      width:             job[:output][:width],
      height:            job[:output][:height],
      status:            job[:output][:status].to_s.downcase,
      status_detail:     job[:output][:status_detail]
    }
  end

  def check_status
    transcoder = AWS::ElasticTranscoder::Client.new(region: Settings.aws.region)
    transcoder.read_job(id: job_id)
  end

  def update_status
    update self.class.aws_response_to_param(check_status)
  end
end
