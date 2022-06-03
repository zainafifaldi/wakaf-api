class BannersController < ApplicationController
  def index
    banners = Banner.active.ordered.all

    render_serializer banners.to_a, Banners::BannerSerializer
  end
end
