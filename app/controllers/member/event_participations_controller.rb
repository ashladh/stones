module Member

  class EventParticipationsController < MemberController

    before_action :get_event_participation, only: [:update]
    before_action :check_character_ownership, only: [:update]

    def create
      @event_participation = EventParticipation.new(event_participation_params)
      check_character_ownership

      @event_participation.updated_by = current_user
      @event_participation.save!
      redirect_to member_calendar_event_path(@event_participation.calendar_event.id)
    end


    def update
      @event_participation.updated_by = current_user
      @event_participation.update!(event_participation_params)
      redirect_to member_calendar_event_path(@event_participation.calendar_event.id)
    end


    private


    def get_event_participation
      @event_participation = EventParticipation.find(params[:id])
    end


    def event_participation_params
      allowed = [:calendar_event_id, :character_id, :presence]
      allowed << :status if current_user.officer?
      params[:event_participation].permit(allowed)
    end


    def check_character_ownership
      character = @event_participation.character
      render_401 unless current_user.officer? || (character && character.user == current_user)
    end

    
  end

end