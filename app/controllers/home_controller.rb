class HomeController < ApplicationController
  def index
    @categories = get_locale_categories
    @sellers = get_locale_sellers
    @tags = get_locale_tags
  end

  def about
  end

  def contact
  end

  def photos
  end

  def resume
  end

  def download_resume
    send_file "#{Rails.root}/app/assets/images/resume/resume-jc-belouard.pdf", type: "application/pdf", x_sendfile: true
  end
end