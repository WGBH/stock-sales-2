class LegalController < ApplicationController
  def show
    @legal = Legal.find_by_path(params[:id])
    @page_title = @legal.title
  end
end