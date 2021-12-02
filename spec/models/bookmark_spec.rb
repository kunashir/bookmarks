require "rails_helper"

RSpec.describe Bookmark, type: :model do
  context "validation" do
    let(:bookmark) { FactoryBot.build(:bookmark) }
    context "url" do
      it "is required" do
        bookmark.url = nil
        expect(bookmark).not_to be_valid
      end
    end
    context "title" do
      it "is required" do
        bookmark.title = nil
        expect(bookmark).not_to be_valid
      end
    end
    context "site" do
      it "belogs to site" do
        bookmark.site = nil
        expect(bookmark).not_to be_valid
      end
    end
  end
end
