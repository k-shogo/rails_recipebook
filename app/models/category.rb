class Category < ActiveRecord::Base
  has_many :categorizes
  has_many :presentations, through: :categorizes
  validates :name, presence: true
end
