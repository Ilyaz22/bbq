class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('controllers.users.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: t('controllers.users.destroyed')
  end

  private

  def set_current_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :avatar)
  end
end
