class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # TODO: shouldn't have to specify .downcase
    if @user = login( params[:session][:username].downcase, 
                      params[:session][:password],
                      params[:session][:remember] = true)
      redirect_back_or_to(:root, success: "Welcome back! -- NOTE: MemoRabble 
        is still under heavy development. If you have any sugestions, or find any
        bugs, let me know! (See 'About' page for contact info.)")
    else
      flash[:alert] = "Login failed."
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: "You've signed out. Come back soon!")
  end
end
