class User < ActiveRecord::Base
	validates :first_name, presence: true, 
	           format: { with: /\A[a-zA-Z]+\-[a-zA-Z]+\Z/, message: "First name contains invalid characters." }
	validates :last_name, presence: true, 
	           format: { with: /\A[a-zA-Z]+\-[a-zA-Z]+\Z/, message: "Last name contains invalid characters." }
	validates :email, presence: true, confirmation: true, message: "Emails do not match."
	validates :email_confirmation, presence: true
	validates :birth_month, presence: true, 
	           inclusion: { in: %w{Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec},
					   message: "%(value) is not a valid month." }
	validates :birth_day, presence: true, 
	           numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
	validates :birth_year, presence: true, 
	           numericality: { only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: Date.today.year }
	validates :gender, presence: true, format: { with: /[MF]/, message: "Select Male or Female." }
end
