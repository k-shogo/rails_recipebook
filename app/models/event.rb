class Event < ActiveRecord::Base
  belongs_to :place
  has_many :presentations
end
