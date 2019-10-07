module Member

  class CalendarEventsController < MemberController

    before_action :get_calendar_event, only: [:edit, :update, :destroy, :show, :preview]
    before_action :check_permissions, only: [:new, :create, :edit, :update, :destroy]


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
      if params[:date]
        @calendar_event.date = params[:date].to_datetime + 21.hours
      end
    end


    def create
      @calendar_event = CalendarEvent.new(calendar_event_params)
      @calendar_event.user = current_user
      @calendar_event.save!
      redirect_to member_calendar_path
    end


    def show
      @event_participation = @calendar_event.user_participation(current_user)
      @event_participations = @calendar_event.event_participations
      @participations_by_role = {}

      @event_participations.each do |participation|
        if participation.persisted?
          @participations_by_role[participation.character.role] ||= []
          @participations_by_role[participation.character.role] << participation
        end
      end
    end


    def preview
      @event_participation = @calendar_event.user_participation(current_user)

      render layout: false
    end


    def edit
    end


    def update
      @calendar_event.update(calendar_event_params)
      redirect_to member_calendar_event_path
    end


    def destroy
      @calendar_event.destroy
      redirect_to member_calendar_path
    end


    private


    def get_calendar_event
      @calendar_event = CalendarEvent.find(params[:id])
    end


    def calendar_event_params
      params[:calendar_event].permit(:name, :date, :description, :raid)
    end


    def check_permissions
      render_401 unless current_user.officer?
    end

  end
  
end