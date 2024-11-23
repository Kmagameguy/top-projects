class StaticPagesController < ApplicationController
  def index
    @photos = if params[:username].present?
                flickr.people.getPublicPhotos(user_id: user_id(params[:username]))
              else
                flickr.interestingness.getList(per_page: 10).photos
              end
    @username = params[:username] if params[:username].present?
  end

  private

  def user_id(username)
    flickr.people.findByUsername(username:).nsid
  end

  def search_params
    params.permit(:username)
  end
end
