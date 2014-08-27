class Event < ActiveRecord::Base
  belongs_to :place
  has_many :presentations
  validates :title, presence: true
end
