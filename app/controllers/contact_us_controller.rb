class ContactUsController < ApplicationController
  def index
    @about = About.find_by_path('contact_us')
  end
end