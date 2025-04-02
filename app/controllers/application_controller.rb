# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_footer_data
  before_action :store_user_location!, if: :storable_location?

  def set_footer_data
    return if params[:controller].split("/").first == "administrate"

    @footer_categories_1 = Category.all.order(created_at: :asc).limit(4)
    @footer_categories_2 = Category.all.order(created_at: :desc).limit(4)
    @footer_articles = Article.all.sample(4)
  end

  private

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      !request.xhr? &&
      !turbo_frame_request?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope)
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referer if resource_or_scope == :user
    super
  end
end
