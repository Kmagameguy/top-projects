class ApplicationController < ActionController::Base
  require 'flickr'

  private

  def flickr
    @flickr = Flickr.new
  end
end
