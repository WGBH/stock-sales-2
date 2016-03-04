class BrochuresController < ApplicationController
  def show
    @brochure = Brochure.find_by_path(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @brochure.title,
               #disposition: 'attachment',
               layout: 'brochure.pdf',
               orientation: 'Landscape',
               page_size: 'Letter'
      end
    end
  end
end
