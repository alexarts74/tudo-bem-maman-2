class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :initialize_session
  before_action :load_cart

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Clothe.find(session[:cart])
  end

end
