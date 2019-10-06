module Member

  class PagesController < MemberController

    def dashboard
      @calendar_events = CalendarEvent.where(:date.gte => DateTime.now, :date.lte => DateTime.now + 2.weeks).asc(:date)
    end


    def calendar
    end


    def roster
      @characters = Character.all
    end

  end

end