class User < ActiveRecord::Base
	attr_accessor :full_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  before_save :capitalize_fields

  has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
  has_many :accepting_friendships, class_name: "Friendship", foreign_key: :accepter_id, dependent: :destroy

  has_many :requesters, through: :accepting_friendships
  has_many :accepters, through: :requesting_friendships

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

	validates :first_name, presence: true

	validates :last_name, presence: true

	validates :email, presence: true, confirmation: true

	validates :email_confirmation, presence: true

	validates :birthday, presence: true

	validates :gender, presence: true, length: { maximum: 1 }, format: { with: /[FM]/ }

	def friends
		self.friends_as_accepter + self.friends_as_requester
	end

	#Friends formed through friendships where someone sent the request to you and you accepted it.
	def friends_as_accepter
		accepted_friendship = self.accepting_friendships.where("accepted = ?", true)

		friends = []

		accepted_friendship.each do |friendship|
			friends << friendship.requester
		end

		friends
	end

	#Friends formed through friendships where you sent the request and someone else accepted it.
	def friends_as_requester
		accepted_friendship = self.requesting_friendships.where("accepted = ?", true)

		friends = []

		accepted_friendship.each do |friendship|
			friends << friendship.accepter
		end

		friends
	end

	def full_name
		@full_name = "#{self.first_name} #{self.last_name}"
	end

	def full_gender
		if self.gender == "M"
			@full_gender = "Male"
		else
			@full_gender = "Female"
		end
	end

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.first_name = auth.info.first_name
			user.last_name = auth.info.last_name
			user.email = auth.info.email
			user.email_confirmation = auth.info.email
			user.password = Devise.friendly_token[0, 20]
			user.gender = auth.extra.raw_info.gender[0].upcase
			#Users logging in through Facebook are 13 or over (as per Facebook's Terms and Data Policy)
			#and eligible to sign up for and use Clonebook.
			#Allow users logged in through Facebook to update their birthdays if they choose to do so.
			user.birthday = Date.today
		end
	end

	private
		def capitalize_fields
			self.first_name.capitalize!
			self.last_name.capitalize!
			self.gender.capitalize!
		end

end