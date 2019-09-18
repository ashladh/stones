class Character
  include Mongoid::Document

  belongs_to :user

  field :playable_class

  field :spec

  field :name

  field :level, type: Integer, default: 60

  field :professions, type: Array, default: ->{[]}

  field :main, type: Boolean, default: true

  field :officer_note, default: ""

  field :class_master, type: Boolean, default: false

end