class Site < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
