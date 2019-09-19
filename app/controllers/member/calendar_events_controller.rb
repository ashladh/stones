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

    def new
      @calendar_event = CalendarEvent.new
    end

    def create
      
      @calendar_event = CalendarEvent.new(calendar_event_params)
      @calendar_event.user = current_user
      @calendar_event.save!
      redirect_to member_calendar_path
    end

    private

    def calendar_event_params
      params[:calendar_event].permit(:name, :date)
    end

  end
  
end