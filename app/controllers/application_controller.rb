class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :load_static_page_info

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      unless admin?
        store_location
        flash[:danger] = "Only admins can do that."
        redirect_to login_url
      end
    end

    def load_static_page_info
      @static_page_info = StaticPage.find_by(id: 1)
    end
end