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

    def show
      @calendar_event = CalendarEvent.find(params[:id])
      character_ids = current_user.characters.map(&:id)
      @event_participation = @calendar_event.event_participations.in(character_id: character_ids).first
      if @event_participation.nil?
        @event_participation = @calendar_event.event_participations.new
      end
    end

    def edit
      @calendar_event = CalendarEvent.find(params[:id])
    end

    def update
      @calendar_event = CalendarEvent.find(params[:id])
      @calendar_event.update(calendar_event_params)
      redirect_to member_calendar_event_path
    end

    def destroy
      @calendar_event = CalendarEvent.find(params[:id])
      @calendar_event.destroy
      redirect_to member_calendar_path
    end

    private

    def calendar_event_params
      params[:calendar_event].permit(:name, :date, :description)
    end

  end
  
end