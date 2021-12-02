require "rails_helper"

RSpec.describe "Bookmarks", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get bookmarks_url
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_bookmark_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      post bookmarks_url, params: {bookmark: {title: "Title", url: "https://f1news.ru/artical1"}}
      expect(response).to have_http_status(:redirect)
      bookmark = Bookmark.last
      expect(bookmark.title).to eq "Title"
    end
  end

  describe "GET /update" do
    it "returns http success" do
      bookmark = FactoryBot.create :bookmark
      patch bookmark_url(bookmark), params: {bookmark: {title: "New title", url: bookmark.url}}
      expect(response).to have_http_status(:redirect)
      bookmark.reload
      expect(bookmark.title).to eq "New title"
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      bookmark = FactoryBot.create :bookmark
      get edit_bookmark_url(bookmark)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      bookmark = FactoryBot.create :bookmark
      delete bookmark_url(bookmark)
      expect(response).to have_http_status(:redirect)
      expect(Bookmark.find_by(id: bookmark.id)).to eq nil
    end
  end
end
