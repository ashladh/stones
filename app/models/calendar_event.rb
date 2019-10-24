class CalendarEvent

  include Mongoid::Document


  field :date,        type: DateTime
  field :started_at,  type: DateTime
  field :name,        type: String, default: ""
  field :description, type: String, default: ""
  field :raid,        type: String, default: ""

  belongs_to :user
  has_many :event_participations, dependent: :destroy


  def for_fullcalendar
    {
      id: _id.to_s,
      title: name,
      start: date,
      url: Rails.application.routes.url_helpers.member_calendar_event_path(self),
      classNames: [raid]
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


  def roster_by_role
    event_participations.roster.reject{|p| p.role.blank?}.group_by(&:role)
  end


  def sidelines_by_role
    event_participations.sidelines.reject{|p| p.role.blank?}.group_by(&:role)
  end


  def refused_participations
    event_participations.refused
  end


  def stats
    stats_ = {
      confirmed: 0,
      stand_by: 0,
      refused: 0,
      tank: 0,
      healer: 0,
      melee: 0,
      range: 0
    }

    event_participations.each do |event_participation|
      status = event_participation.status

      if event_participation.presence == 'absent'
        status = 'refused'
      end

      stats_[status.to_sym] += 1
      if event_participation.role && event_participation.status == 'confirmed' && event_participation.presence != 'absent'
        stats_[event_participation.role.to_sym] += 1
      end
    end

    stats_
  end


  def start!
    self.started_at = DateTime.now
    save!
  end


  def started?
    !started_at.nil?
  end


  def finished?
    started? && ((date + 6.hours) < DateTime.now)
  end

end