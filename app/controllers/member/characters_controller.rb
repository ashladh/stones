module Member

  class CharactersController < MemberController

    before_action :get_character, only: [:edit, :update, :destroy, :show]
    before_action :check_permissions, only: [:edit, :update, :destroy]


    def index
      @characters = Character.all
    end


    def new
      @character = Character.new
    end


    def create
      @character = Character.new(character_params)
      @character.user = current_user
      @character.save!
      redirect_to member_characters_path
    end


    def edit
    end


    def update
      @character.update!(character_params)
      redirect_to member_characters_path
    end


    def destroy
      @character.destroy
      redirect_to member_characters_path
    end


    def show
      @histories = @character.histories.desc(:created_at).limit(10)
    end


    private


    def character_params
      params[:character].permit(:name, :playable_class, :level, :spec, :main, :officer_note, :class_master, :primary_professions => [], :secondary_professions => [])
    end


    def get_character
      @character = Character.find(params[:id])
    end


    def check_permissions
      render_401 unless current_user.can_edit_character? @character
    end

    
  end
  
end