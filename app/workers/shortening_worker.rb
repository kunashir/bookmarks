class ShorteningWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(bookmark_id)
    bookmark = Bookmark.find_by(id: bookmark_id)
    return unless bookmark

    shortening = ShorteningGenerator.perform(bookmark.url)
    bookmark.shortening = shortening
    bookmark.save!
  end
end
