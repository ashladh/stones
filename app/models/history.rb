class History
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :log

end