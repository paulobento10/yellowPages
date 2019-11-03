class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  #GET Users by name
  def showName
    @user = User.by_name(params[:name])
    render json: @user
  end

  #GET Users by local
  def showLocal
    @user = User.by_local(params[:local])
    render json: @user
  end

  #GET Users by name and local
  def showNameLocal
    @user = User.by_name_local(params[:name],params[:local])
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/counter/1
  def updateCounter
    if @user.update(params[:id]) 
      render json: @user.by_updateCounter
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :phoneNumber, :address, :postalCode, :local, :link, :counter) #.require(:user)
    end
end
