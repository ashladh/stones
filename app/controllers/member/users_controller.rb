module Member

  class UsersController < MemberController

    before_action :get_user, only: [:edit, :update, :destroy, :show, :act_as]
    before_action :check_permissions, only: [:edit, :update, :destroy]


    def index
      @users = User.all
    end


    def edit
    end


    def update
      user_params[:rank] = @user.rank if user_params[:rank] == "guild_master"
      @user.update(user_params)

      redirect_to member_user_path @user
    end


    def destroy
      @user.destroy
      redirect_to member_users_path
    end


    def show
    end


    def act_as
      if real_current_user.can_act_as?(@user)
        session[:acting_as_user_id] = params[:id]
        redirect_to request.referer || member_users_url
      else
        render_401
      end
    end


    def stop_acting
      session[:acting_as_user_id] = nil
      redirect_to request.referer || member_users_url
    end


    private


    def user_params
      allowed = [:email, :nickname]
      allowed << :rank if current_user.officer?
      params[:user].permit(allowed)
    end


    def get_user
      @user = User.find(params[:id])
    end


    def check_permissions
      render_401 unless current_user.can_edit_user? @user
    end


  end
  
end