class User < ActiveRecord::Base
	attr_accessor :full_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :capitalize_fields

  has_many :requesting_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
  has_many :accepting_friendships, class_name: "Friendship", foreign_key: :accepter_id, dependent: :destroy

  has_many :requesters, through: :accepting_friendships
  has_many :accepters, through: :requesting_friendships

  has_many :posts

	validates :first_name, presence: true

	validates :last_name, presence: true

	validates :email, presence: true, confirmation: true

	validates :email_confirmation, presence: true

	validates :birthday, presence: true

	validates :gender, presence: true, format: { with: /[mMfF]/, message: ": Select (M)ale or (F)emale." }

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

	private
		def capitalize_fields
			self.first_name.capitalize!
			self.last_name.capitalize!
			self.gender.capitalize!
		end

end