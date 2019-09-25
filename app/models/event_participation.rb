class EventParticipation
  include Mongoid::Document

  belongs_to :calendar_event
  belongs_to :character

  field :presence, type: String, default: 'invited'
  field :status, type: String, default: 'stand_by'

  validates_uniqueness_of :character_id, scope: [:calendar_event_id]

end