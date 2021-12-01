class CreateBookmarkService < BaseService
  attr_reader :url, :title, :shortening
  DOMAIN_REGEX = /^(?:https?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n?]+)/
  def initialize(args)
    args = args.symbolize_keys
    @title = args[:title]
    @url = args[:url]
    @shortening = args[:shortening]
  end

  def perform
    site = Site.find_or_create_by(url: extract_site_url(url))
    bookmark = Bookmark.create(title: title, url: url, shortening: shortening, site: site)
    ShorteningWorker.perform_async(bookmark.id) if shortening.nil? && bookmark.valid?
    bookmark
  end

  private

  def extract_site_url(url)
    m = DOMAIN_REGEX.match(url)
    return unless m
    m[1]
  end
end
