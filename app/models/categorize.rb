class Categorize < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :category
  validates :presentation, :category, presence: true
  validates :presentation, uniqueness: {scope: :category}
end
