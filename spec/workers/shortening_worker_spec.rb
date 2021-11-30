require 'rails_helper'
RSpec.describe ShorteningWorker, type: :worker do
  describe "execution" do
    it "updates shortening for a Bookmark" do
      bookmark = FactoryBot.create(:bookmark)
      allow(ShorteningGenerator).to receive(:perform).with(bookmark.url).and_return("short_url")
      ShorteningWorker.new.perform(bookmark.id)
      bookmark.reload
      expect(bookmark.shortening).to eq "short_url"
    end

    it "return nothing if no bookmark in DB" do
      expect(ShorteningWorker.new.perform("bad id")).to eq nil
    end
  end
end
