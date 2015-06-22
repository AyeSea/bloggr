class StaticpagesController < ApplicationController
	before_filter :redirect_loggedin_user

  def home
  end

  private
    def redirect_loggedin_user
      redirect_to current_user if current_user != nil
    end
end
