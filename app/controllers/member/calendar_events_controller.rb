module Member

  class CalendarEventsController < MemberController

    def index
      @calendar_events = CalendarEvent.all

      respond_to do |format|
        format.json {
          render json: @calendar_events.map(&:for_fullcalendar)
        }
      end
    end

  end
  
end