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

  #GET Users by delta
  def showDelta
    @user = User.offset(0).limit(params[:delta])
    render json: @user
  end

  #GET Users by offset & delta
  def showOffsetDelta
    offset = Integer(params[:offset]) * Integer(params[:delta])
    @user = User.offset(offset).limit(params[:delta])
    render json: @user
  end
  
  #GET Users by most searched
  def showMostSearched
    @user = User.order('counter DESC').limit(params[:limit])
    render json: @user
  end

  #GET Users by like name
  def showUsersLikeName
    @users = User.all
    if params[:likeName].present? && params[:offset].present? && params[:delta].present?
      @users = @users.where("LOWER(name) LIKE LOWER(?)","%#{params[:likeName]}%").offset(0).limit(params[:delta])
    else
      @users = User.all #isto é desnecessário
    end
    render json: @users
  end

  #GET Users by like local
  def showUsersLikeLocal
    @users = User.all
    if params[:likeLocal].present? && params[:offset].present? && params[:delta].present?
      @users = @users.where("LOWER(local) LIKE LOWER(?)", "%#{params[:likeLocal]}%").offset(0).limit(params[:delta])
    else
      @users = User.all #isto é desnecessário
    end
    render json: @users
  end

  #GET Users by like name and local
  def showUsersLikeNameLocal
    @users = User.all
    if params[:likeName].present? && params[:likeLocal].present? && params[:offset].present? && params[:delta].present?
      @users = @users.where("LOWER(name) LIKE LOWER(?) AND LOWER(local) LIKE LOWER(?) ", "%#{params[:likeName]}%","%#{params[:likeLocal]}%").offset(0).limit(params[:delta])
    else
      @users = User.all #isto é desnecessário
    end
    render json: @users
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
    #if @user.update(params[:id])
    #  render json: @user.increment(:counter,1)
    #else
    #  render json: @user.errors, status: :unprocessable_entity
    #end
    if @user  = User.find(params[:id])
      @user.increment(:counter,1)
      render @user.update(user_params)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
    #render json: @user
  end

  # PATCH/PUT /users/editForm/1
  def editForm
    @user = User.find(params[:id])
    @user.update(editForm_params)
    render json: @user
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

    def editForm_params
      params.permit(:name, :address)
    end
end
