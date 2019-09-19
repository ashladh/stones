class CalendarEvent
  include Mongoid::Document

  field :date, type: DateTime

  field :name, type: String, default: ""

  #has_many :participants

end