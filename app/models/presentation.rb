class Presentation < ActiveRecord::Base
  include Identifiable
  include Commentable
  include Presentation::Transcodeable
  include PublicActivity::Model
  tracked

  belongs_to :event
  has_many :documents
  has_many :transcodes
  has_many :categorizes
  has_many :categories, through: :categorizes

  validates :title, presence: true

  mount_uploader      :video, VideoUploader
  store_in_background :video, VideoUploadWorker

  identitire_field :uuid
end
