class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  # check authorization
  authorize_resource
  
  def new
    @user = User.new
    @instructor = @user.instructor
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@instructor.proper_name}'s controller was revised in the system."
      redirect_to @instructor
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Successfully removed the user for #{@instructor} from the system."
    redirect_to instructors_url
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user && (current_user.role?(:admin) || current_user.role?(:instructor))
        params.require(:user).permit(:username, :instructor_id, :password, :password_confirmation, :role, :active)  
      else
        # guests do not have instructor ids nor roles
        params.require(:user).permit(:username, :password, :password_confirmation, :active) 
      end
    end
end
