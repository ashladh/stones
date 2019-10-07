class EventParticipation
  include Mongoid::Document

  belongs_to :calendar_event
  belongs_to :character

  field :presence, type: String, default: 'invited'
  field :status, type: String, default: 'stand_by'

  validates_uniqueness_of :character_id, scope: [:calendar_event_id]


  scope :roster, -> {
    any_of(
      {presence: 'accepted'},
      {presence: 'tentative'}
    ).where(status: 'confirmed')
  }

  scope :sidelines, -> {
    any_of(
      {presence: 'accepted'},
      {presence: 'tentative'}
    ).where(status: 'stand_by')
  }

  scope :refused, -> {
    any_of(
      {presence: 'absent'},
      {status: 'refused'}
    )
  }


  def role
    character.role if persisted?
  end


end