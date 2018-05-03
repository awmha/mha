class StaticPagesController < ApplicationController
  layout "public"
  before_action :logged_in_user, only: [:show, :edit, :update, :set_social_media]
  
  def home
    @projects = Project.all
  end

  def contact
    @projects = Project.all
  end

  def show
    @static_page = StaticPage.find(params[:id])

    render layout: 'admin'
  end

  def edit
    @static_page = StaticPage.find(params[:id])

    render layout: 'admin'
  end

  def update
    @static_page = StaticPage.find(params[:id])

    set_social_media

    if @static_page.update_attributes(static_page_params)
      flash[:success] = "Page information has successfully been updated."
      redirect_to @static_page
    else
      render action: "edit", flash: { error: "An error occurred while updating page information." }
    end
  end

  def set_social_media
    @static_page.social_media.clear

    if params[:social_media_values]
      params[:social_media_values].each do |index, value|
        if not value.blank?
          type = params[:social_media][index]
          @static_page.social_media[type] = value
        end
      end
    end
  end

  private

  def static_page_params
    params.require(:static_page).permit(:company_name, :address_line_1, :address_line_2, :phone_number, :fax_number, :company_email, :contact_text, :about_us, :meta_description, :meta_keywords, :logo)
  end
end