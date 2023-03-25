class SitemapController < ApplicationController
  def show
    locale = request.path.split("/").second.to_sym
  end
end
