FactoryBot.define do
  sequence(:url) { |n| "https://reddit.com/formula1-#{n}" }

  factory :bookmark do
    title { "F1 forum" }
    url
    # sequence(:url) { |n| "https://reddit.com/formula1-#{n}" }
    shortening { "https://f1.x" }
    site
  end

  factory :site do
    url { "https://reddit.com" }
  end
end
