module Member

  class PagesController < MemberController
    def dashboard
    end

    def calendar
    end

    def roster
      @characters = Character.all
    end
  end

end