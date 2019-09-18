module Member

  class CharactersController < MemberController

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
      @character = Character.find(params[:id])
    end

    def update
      @character = Character.find(params[:id])
      @character.update!(character_params)
      redirect_to member_characters_path
    end

    def destroy
      @character = Character.find(params[:id])
      @character.destroy
      redirect_to member_characters_path
    end

    private

    def character_params
      params[:character].permit(:name, :playable_class, :level, :spec, :professions, :main, :officer_note, :class_master)
    end

  end
  
end