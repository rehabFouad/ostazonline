class AdminController < ApplicationController
  # GET /Users
  # GET /Users.json
  def index
    authorize! :manage, User
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /Users/1
  # GET /Users/1.json
  def reset
    @user = User.find(params[:id])
    @user.update_attribute(:password, "123456");
    respond_to do |format|
      if(@user.save!)
        flash[:notice] = 'User password reset completed successfully - new password is 123456.'

        format.html { redirect_to logons_path  }
        format.json { render json: @user }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
   (5-@user.permissions.count).times do @user.permissions.build end
  end
  
 def update
  @user = User.find(params[:id])

  respond_to do |format|
    if @user.update_attributes(params[:user])
      format.html { redirect_to logons_path, notice: 'user was successfully updated.' }
      format.json { head :no_content }
    else
      format.html { render action: "edit" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end
  # # GET /Users/new
  # # GET /Users/new.json
  # def new
    # @user = User.new
    # @user_types = User.types
    # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @user }
    # end
  # end
# 
  # # POST /Users
  # # POST /Users.json
  # def create
    # @user = User.new(params[:User])
# 
    # respond_to do |format|
      # if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        # format.json { render json: @user, status: :created, location: @user }
      # else
        # @user_types = User.types
        # flash[:error] = @user.errors.full_messages.join(",")
# 
        # format.html { render action: "new" }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      # end
    # end
  # end
# 
  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if(@user.destroy)
        flash[:notice] = 'User was successfully destroyed.'
        
        format.html { redirect_to logons_path  }
        format.json { head :no_content }
      end
    end
  end
end
