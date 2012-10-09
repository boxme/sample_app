class UsersController < ApplicationController
  
  def show
	  @user = User.find(params[:id])
	  #the line above is the same as User.find(id)
  end
  
  def new
	  @title = "Sign up"
  end
  
end
