class TranscodeCheckWorker
  include Sidekiq::Worker
  sidekiq_options queue: :transcode, unique: :all, manual: true

  def self.lock
    "#{self.name.underscore}:lock"
  end

  # Implement method to handle lock removing manually
  def self.unlock!
    Sidekiq.redis { |conn| conn.del(self.lock) }
  end

  def self.sqs_response_to_param sqs_response
    json_response = JSON.parse sqs_response
    msg = json_response['Message']
    job = JSON.parse msg
    {
      job_id:            job['jobId'],
      duration:          job['outputs'][0]['duration'],
      width:             job['outputs'][0]['width'],
      height:            job['outputs'][0]['height'],
      status:            job['outputs'][0]['status'].to_s.downcase,
      status_detail:     job['outputs'][0]['statusDetail']
    }
  end

  def perform
    sqs = AWS::SQS.new

    # ロングポーリングでメッセージを取得
    sqs.queues[Settings.sqs_queue_url].poll(idle_timeout: 30) do |msg|
      param = self.class.sqs_response_to_param msg.body
      p param
      transcode = Transcode.find_by(job_id: param[:job_id])
      if transcode
        transcode.update(param)
        transcode.create_activity :update_status, owner: transcode.presentation

        @message = Message.new(type: :success, icon: :video, header: 'Transcode done', body: "#{transcode.job_id} transcode done")
        view = ActionView::Base.new(Rails.root.join('app/views'))
        view.extend SemanticIconHelper
        html = view.render partial: 'messages/message', locals: {message: @message}
        data = {html: html}
        WebsocketRails[:messages].trigger :message, data.to_json
      end
    end

    self.class.unlock!
    self.class.perform_async if Transcode.submitted.count.nonzero?
  end
end
