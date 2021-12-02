# frozen_string_literal: true

require "rails_helper"

RSpec.describe CreateBookmarkService do
  let(:payload) {
    {
      "title" => "Formula 1",
      "url" => "https://formula1.org",
      "shortening" => nil
    }
  }
  before do
    ShorteningWorker.clear
  end

  context "site" do
    it "creates site if it does not exist in DB" do
      expect { CreateBookmarkService.perform(payload) }.to change { Site.count }.by(1)
    end

    it "does not create site if it exists in DB" do
      FactoryBot.create(:site, url: "formula1.org")
      expect { CreateBookmarkService.perform(payload) }.not_to change { Site.count }
    end
  end

  context "bookmark" do
    it "create a bookmark" do
      expect { CreateBookmarkService.perform(payload) }.to change { Bookmark.count }.by(1)
    end

    it "fills necessary field accordingly" do
      bookmark = CreateBookmarkService.perform(payload)
      expect(bookmark.url).to eq payload["url"]
      expect(bookmark.title).to eq payload["title"]
      expect(bookmark.site).not_to be_nil
    end

    it "returns bookmark with errors if params are invalid" do
      payload["url"] = nil
      bookmark = CreateBookmarkService.perform(payload)
      expect(bookmark).not_to be_valid
      expect(bookmark.errors).not_to be_empty
    end
  end

  context "shortening" do
    it "schedule job for getting shortening if it is empty" do
      expect { CreateBookmarkService.perform(payload) }.to change(ShorteningWorker.jobs, :size).by(1)
    end

    it "does nothing if shortening exists" do
      payload["shortening"] = "https://curll.ly/f1"
      expect { CreateBookmarkService.perform(payload) }.not_to change(ShorteningWorker.jobs, :size)
    end

    it "does not schedule job if bookmark is not valid" do
      payload["url"] = ""
      expect { CreateBookmarkService.perform(payload) }.not_to change(ShorteningWorker.jobs, :size)
    end
  end
end
