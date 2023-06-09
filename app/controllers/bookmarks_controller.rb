class BookmarksController < ApplicationController
  before_action :find_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(strong_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), status: :see_other
  end

  private

  def find_list
    @list = List.find(params[:list_id])
  end

  def strong_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
