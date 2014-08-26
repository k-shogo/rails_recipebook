class Presentation < ActiveRecord::Base
  include Identifiable
  include Presentation::Transcodeable
  include PublicActivity::Model
  tracked

  belongs_to :event
  belongs_to :category
  has_many :documents
  has_many :transcodes

  mount_uploader      :video, VideoUploader
  store_in_background :video, VideoUploadWorker

  identitire_field :uuid
end
