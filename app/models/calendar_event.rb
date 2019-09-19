class CalendarEvent

  include Mongoid::Document

  field :date, type: DateTime
  field :name, type: String, default: ""

  belongs_to :owner
  has_many :event_participations

end