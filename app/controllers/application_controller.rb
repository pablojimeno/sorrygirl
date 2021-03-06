# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_pages

  private

  def require_signin
    return nil if current_user
    session[:intended_url] = request.url
    redirect_to new_session_url, alert: 'Please sign in first'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user?(user)
    current_user == user
  end
  helper_method :current_user?

  # This makes the pages show up in the navbar
  def set_pages
    @pages = Page.all
  end
end
