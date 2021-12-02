class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = CreateBookmarkService.perform(bookmark_params)
    if @bookmark.valid?
      flash[:info] = "The bookmark was created successfully"
      redirect_to bookmarks_url
    else
      render :edit
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      flash[:info] = "The bookmark was updated successfully"
      redirect_to bookmarks_url
    else
      render :edit
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    if bookmark.destroy
      flash[:info] = "The bookmark was destroy successfully"
    else
      flash[:error] = "The bookmark was not destroy successfully"
    end
    redirect_to bookmarks_url
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :shortening)
  end
end
