require "rails_helper"

RSpec.describe Site, type: :model do
  context "validations" do
    it { expect(Site.new).not_to be_valid }

    it "has uniq URL" do
      existing_site = FactoryBot.create(:site)
      new_site = Site.new(url: existing_site.url)
      expect(new_site.valid?).to eq false
    end
  end
end
