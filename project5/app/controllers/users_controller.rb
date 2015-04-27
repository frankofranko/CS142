class UsersController < ApplicationController
  def index
      @user_info = User.all
      
  end
  
  def login
  end
  
  def new
      if session[:user]
          redirect_to(:controller => :photos, :action => :index, :id => session[:user])
      end
      @user = User.new()
  end
  
  def create
      @user = User.new(user_params(params[:user]))
      
#      @user.password_confirmation = params[:user][:password_confirmation]

      if @user.save()
          redirect_to :action => :login
      else
          error_str = ""
          @user.errors.full_messages.each do |msg|
              error_str = error_str +" "+ msg+"."
          end
      
          flash[:error] = "Incorrect Information."+error_str
          redirect_to :action => :new
      end
      
  end
  
  
  def post_login
      
      user = User.find_by_login(params[:user_name])
      if user
          if user.password_valid?(params[:password])
              session[:user] = user.id
              redirect_to(:controller => :photos, :action => :index, :id => user.id)
          else
              flash[:notice] = "Wrong password."
              redirect_to :action => :login
          end
      else
          flash[:notice] = "No such user."
          redirect_to :action => :login
      end

      
  end
  
  def logout
      reset_session
      redirect_to(:action => :login)
  end
  
  def user_params(params)
      return params.permit(:user,:first_name,:last_name,:login,:password,:password_confirmation)
  end
  
end
