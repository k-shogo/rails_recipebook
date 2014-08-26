CarrierWave.configure do |config|
  if Settings.image_upload_destination == :fog
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Settings.aws.access_key,
      aws_secret_access_key: Settings.aws.secret,
      region:                Settings.aws.region
    }
    config.fog_directory = Settings.aws.s3_upload_bucket
  end
end
