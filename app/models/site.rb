class Site < ApplicationRecord
  has_many :bookmarks
  validates :url, presence: true, uniqueness: true
end
