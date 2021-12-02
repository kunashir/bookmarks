require 'rails_helper'

RSpec.describe "bookmarks/edit.html.erb", type: :view do
  it "show the form with bookmark data" do
    bookmark = FactoryBot.create(:bookmark)
    assign(:bookmark, bookmark)

    render

    expect(rendered).to match(/form/)
    expect(rendered).to match(bookmark.title)
    expect(rendered).to match(bookmark.url)
  end
end
