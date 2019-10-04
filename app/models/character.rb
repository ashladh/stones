class Character
  include Mongoid::Document
  include Mongoid::Slug


  field :playable_class
  field :spec

  field :name
  slug :name

  field :level, type: Integer, default: 60
  field :primary_professions, type: Array, default: ->{[]}
  field :secondary_professions, type: Array, default: ->{[]}
  field :main, type: Boolean, default: true
  field :officer_note, default: ""
  field :class_master, type: Boolean, default: false


  belongs_to :user
  has_many :event_participations

  before_save :sanitize_professions
  before_create :ensure_main
  before_save :ensure_main_uniqueness


  private


  def sanitize_professions
    self.primary_professions = primary_professions.select{|p| !p.blank? }
    self.secondary_professions = secondary_professions.select{|p| !p.blank? }
  end


  def ensure_main
    unless user.has_character?
      self.main = true
    end
  end


  def ensure_main_uniqueness
    if main_changed? && main
      user.characters.each do |character|
        if character != self
          character.main = false
          character.save!
        end
      end
    end
  end


end