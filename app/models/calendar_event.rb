class CalendarEvent

  include Mongoid::Document


  field :date, type: DateTime
  field :name, type: String, default: ""

  belongs_to :user
  has_many :event_participations


  def for_fullcalendar
    {
      title: name,
      start: date
    }
  end

end