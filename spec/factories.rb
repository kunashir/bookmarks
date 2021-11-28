FactoryBot.define do
  factory :bookmark do
    title { "F1 forum" }
    url { "https://reddit.com/formula1" }
    shortening { "https://f1.x" }
    site
  end

  factory :site do
    url { "https://reddit.com"  }
  end
end

