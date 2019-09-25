class CalendarEvent

  include Mongoid::Document


  field :date, type: DateTime
  field :name, type: String, default: ""
  field :description, type: String, default: ""
  field :type, type: String, default: "raid"

  belongs_to :user
  has_many :event_participations


  def for_fullcalendar
    {
      id: _id.to_s,
      title: name,
      start: date,
      url: Rails.application.routes.url_helpers.member_calendar_event_path(self)
    }
  end


  def user_participation user
    character_ids = user.characters.map(&:id)
    event_participation = event_participations.in(character_id: character_ids).first

    if event_participation.nil?
      event_participation = event_participations.new
    end

    event_participation
  end

end