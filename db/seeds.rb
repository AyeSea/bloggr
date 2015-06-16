# ruby encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: 'Homer', last_name: 'Simpson', email: 'hsimpson@example.com', email_confirmation: 'hsimpson@example.com',
	           password: 'password', gender: 'M', birthday: "1979-01-01")

User.create!(first_name: 'Marge', last_name: 'Simpson', email: 'msimpson@example.com', email_confirmation: 'msimpson@example.com',
	           password: 'password', gender: 'F', birthday: "1979-01-01")

User.create!(first_name: 'Bart', last_name: 'Simpson', email: 'bsimpson@example.com', email_confirmation: 'bsimpson@example.com',
	           password: 'password', gender: 'M', birthday: "2006-01-01")

User.create!(first_name: 'Lisa', last_name: 'Simpson', email: 'lsimpson@example.com', email_confirmation: 'lsimpson@example.com',
	           password: 'password', gender: 'F', birthday: "2007-01-01")

User.create!(first_name: 'Maggie', last_name: 'Simpson', email: 'babysimpson@example.com', email_confirmation: 'babysimpson@example.com',
	           password: 'password', gender: 'F', birthday: "2014-01-01")