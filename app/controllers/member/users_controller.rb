module Member

  class UsersController < MemberController

    before_action :get_user, only: [:edit, :update, :destroy, :show]
    before_action :check_permissions, only: [:edit, :update, :destroy]


    def index
      @users = User.all
    end


    def edit
    end


    def update
      if @user == current_user || @user.officer?
        user_params[:rank] = @user.rank if user_params[:rank] == "guild_master"
        @user.update(user_params)
      end
      redirect_to member_users_path
    end


    def destroy
      @user.destroy
      redirect_to member_users_path
    end

    def show
    end


    private

    def user_params
      permitted_params = params[:user].permit(:email, :nickname)
      if current_user.officer?
        permitted_params = permitted_params.permit(:rank)
      end
      permitted_params
    end


    def get_user
      @user = User.find(params[:id])
    end

    def check_permissions
      unless @user == current_user || current_user.officer?
        redirect_to member_users_path
        return
      end
    end
    
  end
  
end