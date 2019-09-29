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
    end


    def create
      @calendar_event = CalendarEvent.new(calendar_event_params)
      @calendar_event.user = current_user
      @calendar_event.save!
      redirect_to member_calendar_path
    end


    def show
      @event_participation = @calendar_event.user_participation(current_user)
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
      params[:calendar_event].permit(:name, :date, :description)
    end


    def check_permissions
      unless current_user.officer?
        redirect_to member_calendar_path
        return
      end
    end


  end
  
end