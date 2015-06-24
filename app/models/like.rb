class Like < ActiveRecord::Base
	belongs_to :user
	#"likeable" objects include instances of the Post and Comment classes
	belongs_to :likeable, polymorphic: true
end