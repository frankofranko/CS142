class UsersController < ApplicationController
  def index
      @user_info = User.all
      
  end
end
