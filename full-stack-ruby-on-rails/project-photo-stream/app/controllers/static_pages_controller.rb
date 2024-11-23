class StaticPagesController < ApplicationController
  def index
    @photos = flickr.interestingness.getList(per_page: 10).photos
  end
end
