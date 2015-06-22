require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new
	end

	def errors_count(user)
		user.errors.full_messages.count
	end

	#stub test
  test "the truth" do
     assert true
  end

  test "user is created when all fields are correctly provided" do
  	@archer = User.new(first_name: "Sterling", last_name: "Archer", email: "sarcher@example.com", email_confirmation: "sarcher@example.com",
  	                   password: "password", password_confirmation: "password", gender: "M", birthday: "1980-01-01")
  	assert @archer.save, "User wasn't created even though all fields were correctly provided."
  end

  test "user cannot be created with blank fields" do
  	assert_not @user.save, "User created with blank fields."
  end

  test "user cannot be created without first name" do
		@other_user = User.new(last_name: "Archer", email: "sarcher@example.com", email_confirmation: "sarcher@example.com",
  	                       password: "password", password_confirmation: "password", gender: "M", birthday: "1980-01-01")
		assert_not @other_user.save
		assert_equal "First name can't be blank", @other_user.errors.full_messages.first
		assert_equal 1, errors_count(@other_user)
  end

  test "user cannot be created without last name" do
		@other_user = User.new(first_name: "Sterling", email: "sarcher@example.com", email_confirmation: "sarcher@example.com",
  	                       password: "password", password_confirmation: "password", gender: "M", birthday: "1980-01-01")
		assert_not @other_user.save
		assert_equal "Last name can't be blank", @other_user.errors.full_messages.first
		assert_equal 1, errors_count(@other_user)
  end

  test "user cannot be created without email and email confirmation" do
		@other_user = User.new(first_name: "Sterling", last_name: "Archer",
  	                       password: "password", password_confirmation: "password", gender: "M", birthday: "1980-01-01")
		assert_not @other_user.save
		assert_equal "Email can't be blank", @other_user.errors.full_messages.first
		assert_equal "Email confirmation can't be blank", @other_user.errors.full_messages.last
		#shows "email can't be blank" error message twice
		assert_equal 3, errors_count(@other_user)
  end

  test "user cannot be created without password and password confirmation" do
		@other_user = User.new(first_name: "Sterling", last_name: "Archer", email: "sarcher@example.com", 
			                     email_confirmation: "sarcher@example.com", gender: "M", birthday: "1980-01-01")
		assert_not @other_user.save
		assert_equal "Password can't be blank", @other_user.errors.full_messages.first
		assert_equal "Password can't be blank", @other_user.errors.full_messages.last
		assert_equal 1, errors_count(@other_user)
  end

  test "user cannot be created without birthday" do
		@other_user = User.new(first_name: "Sterling", last_name: "Archer", email: "sarcher@example.com", email_confirmation: "sarcher@example.com",
  	                       password: "password", password_confirmation: "password", gender: "M")
		assert_not @other_user.save
		assert_equal "Birthday can't be blank", @other_user.errors.full_messages.first
		assert_equal 1, errors_count(@other_user)
  end

  test "user cannot be created without gender" do
  	@other_user = User.new(first_name: "Sterling", last_name: "Archer", email: "sarcher@example.com", email_confirmation: "sarcher@example.com",
  		                     password: "password", password_confirmation: "password", birthday: "1980-01-01")
  	assert_not @other_user.save
  	assert_equal "Gender can't be blank", @other_user.errors.full_messages.first
  	assert_equal "Gender : Select (M)ale or (F)emale.", @other_user.errors.full_messages.last
  	assert_equal 2, errors_count(@other_user)
  end

  test "user must have the same email and email confirmation" do
  	@other_user = User.new(first_name: "Sterling", last_name: "Archer", email: "sarcher@example.com", email_confirmation: "chetmanley@example.com",
  		                     password: "password", password_confirmation: "password", birthday: "1980-01-01", gender: "M")
  	assert_not @other_user.save
  	assert_equal "Email confirmation doesn't match Email", @other_user.errors.full_messages.first
  	assert_equal 1, errors_count(@other_user)
  end
end
