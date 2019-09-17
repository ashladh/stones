module Member

  class UsersController < MemberController

    def index
      @users = User.all
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to member_users_path
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to member_users_path
    end

    private

    def user_params
      params[:user].permit(:email, :nickname, :rank)
    end

  end
  
end