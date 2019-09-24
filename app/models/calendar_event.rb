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
      title: name,
      start: date,
      url: Rails.application.routes.url_helpers.member_calendar_event_path(self)
    }
  end

end