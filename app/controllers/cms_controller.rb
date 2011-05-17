class CmsController < ApplicationController
  include AbstractController::Layouts
  include ActionController::Rendering
  include AbstractController::Helpers
  
  append_view_path SqlTemplate::Resolver.instance
  helper CmsHelper
  
  def welcome
    respond
  end
  
  def respond
    render :template => params[:page]
  end
end