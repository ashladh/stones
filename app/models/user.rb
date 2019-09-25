class User
  include Mongoid::Document


  ## Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String


  field :rank, type: String, default: "registered"
  field :nickname
  field :dkp, type: Integer, default: 0

  has_many :characters
  has_many :histories
  has_many :calendar_events

  def registered?
    rank == 'registered' || member?
  end

  def member?
    rank == 'member' || officer?
  end

  def officer?
    rank == 'officer' || guild_master?
  end

  def guild_master?
    rank == 'guild_master'
  end

end
