module Member

  class EventParticipationsController < MemberController


    def create
      @event_participation = EventParticipation.new(event_participation_params)
      @event_participation.save!
      redirect_to member_calendar_event_path(@event_participation.calendar_event.id)
    end


    def update
      @event_participation = EventParticipation.find(params[:id])
      @event_participation.update!(event_participation_params)
      redirect_to member_calendar_event_path(@event_participation.calendar_event.id)
    end


    private


    def event_participation_params
      params[:event_participation].permit(:calendar_event_id, :character_id, :presence, :status)
    end

    
  end

end