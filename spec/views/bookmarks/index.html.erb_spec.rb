require "rails_helper"

RSpec.describe "bookmarks/index.html.erb", type: :view do
  it "displays all the Bookmarks" do
    site = FactoryBot.create :site
    bookmarks = FactoryBot.create_list(:bookmark, 2, site: site)
    assign(:bookmarks, Bookmark.all)

    render

    bookmarks.each do |bookmark|
      expect(rendered).to match(bookmark.title)
    end
  end
end
