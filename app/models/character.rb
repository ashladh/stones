class Character
  include Mongoid::Document

  belongs_to :user

  field :playable_class

  field :spec

  field :name

  field :level, type: Integer, default: 60

  field :primary_professions, type: Array, default: ->{[]}

  field :secondary_professions, type: Array, default: ->{[]}

  field :main, type: Boolean, default: true

  field :officer_note, default: ""

  field :class_master, type: Boolean, default: false

  before_save do
    self.primary_professions = primary_professions.select{|p| !p.blank? }
    self.secondary_professions = secondary_professions.select{|p| !p.blank? }
  end

end