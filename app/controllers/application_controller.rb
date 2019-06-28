class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    before_action :authenticate_user!
    before_action do |controller|
      flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice]
    end

    protect_from_forgery


    
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end

    private

    def render_404
      render nothing: true, status: 404
    end
end
