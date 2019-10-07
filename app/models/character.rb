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
  has_many :event_participations, dependent: :destroy

  before_save :sanitize_professions
  before_create :ensure_main
  before_save :ensure_main_uniqueness



  def class_and_spec
    "#{playable_class}_#{spec}"
  end

  def role
    Character.role_for class_and_spec
  end


  def self.role_for class_and_spec
    roles = {
      warrior_protection: "tank",
      warrior_arms: "melee",
      warrior_fury: "melee",
      druid_guardian: "tank",
      druid_feral: "melee",
      druid_druidrestoration: "healer",
      druid_balance: "range",
      hunter_marksmanship: "range",
      hunter_beastmastery: "range",
      hunter_survival: "range",
      warlock_destruction: "range",
      warlock_affliction: "range",
      warlock_demonology: "range",
      shaman_enhancement: "melee",
      shaman_elemental: "range",
      shaman_shamanrestoration: "healer",
      priest_holy: "healer",
      priest_discipline: "healer",
      priest_shadow: "range",
      rogue_assassination: "melee",
      rogue_combat: "melee",
      rogue_subtelty: "melee",
      mage_arcane: "range",
      mage_fire: "range",
      mage_frost: "range"
    }
    roles[class_and_spec.to_sym]
  end


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