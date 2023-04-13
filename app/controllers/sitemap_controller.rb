class SitemapController < ApplicationController
  # an action that shows a page with links to other pages of the site - a sitemap
  def index
    respond_to do |format|
      format.html
      format.xml
    end
  end
end
