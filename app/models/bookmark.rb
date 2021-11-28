class Bookmark < ApplicationRecord
  belongs_to :site
  validates :url, :title, presence: true
end
