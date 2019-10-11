class History
  include Mongoid::Document
  include Mongoid::Timestamps


  belongs_to :subject, polymorphic: true

  field :type

  field :data, type: Hash, default: -> {{}}

  field :actor_id


  def actor
    @actor ||= User.find(actor_id) if actor_id
  end


end