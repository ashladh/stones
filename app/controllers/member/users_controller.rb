module Member

  class UsersController < MemberController

    before_action :get_user, only: [:edit, :update, :destroy]


    def index
      @users = User.all
    end


    def edit
    end


    def update
      @user.update(user_params)
      redirect_to member_users_path
    end


    def destroy
      @user.destroy
      redirect_to member_users_path
    end


    private

    def user_params
      params[:user].permit(:email, :nickname, :rank)
    end


    def get_user
      @user = User.find(params[:id])
    end

    
  end
  
end