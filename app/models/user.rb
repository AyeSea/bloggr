class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :capitalize_fields

	validates :first_name, presence: true

	validates :last_name, presence: true

	validates :email, presence: true, confirmation: true

	validates :email_confirmation, presence: true

	validates :birthday, presence: true

	validates :gender, presence: true, format: { with: /[mMfF]/, message: ": Select (M)ale or (F)emale." }

	private
	def capitalize_fields
		self.first_name.capitalize!
		self.last_name.capitalize!
		self.gender.capitalize!
	end

end