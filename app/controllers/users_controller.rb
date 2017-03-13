class UsersController < ApplicationController

  before_action :require_login, only: [:show]

  
  def index
    @users = User.all
  end

  def new
    # we make a new user
    # to pass to the form view later
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    login(@user) # <-- log the user in
    redirect_to @user # <-- go to show
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end




  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
