class VideoUploadWorker < ::CarrierWave::Workers::StoreAsset

  def perform(*args)
    super
    record = constantized_resource.find id
    record.transcode
  end

end
