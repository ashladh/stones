module Member

  class EventParticipationsController < MemberController

    before_action :check_character_ownership, only: [:create, :update]

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
      permitted_params = params[:event_participation].permit(:calendar_event_id, :character_id, :presence)
      if current_user.officer?
        permitted_params = permitted_params.permit(:status)
      end
      permitted_params
    end

    def check_character_ownership
      character = Character.find(event_participation_params[:character_id])
      if character && character.user != current_user
        raise "Sors de mon code :)"
      end
    end

    
  end

end