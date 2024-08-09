# frozen_string_literal: true

class HomeController < ApplicationController
  def index
  end

  def about
    add_breadcrumb t("breadcrumbs.home"), root_path
    add_breadcrumb t("about_us.title")
  end
end
