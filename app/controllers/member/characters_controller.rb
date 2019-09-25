module Member

  class CharactersController < MemberController

    before_action :get_character, only: [:edit, :update, :destroy, :show]


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
    end


    private


    def character_params
      params[:character].permit(:name, :playable_class, :level, :spec, :main, :officer_note, :class_master, :primary_professions => [], :secondary_professions => [])
    end


    def get_character
      @character = Character.find(params[:id])
    end

    
  end
  
end