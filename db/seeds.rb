# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
# Setup initial user so we can get in
user = User.create! :name => 'Becca Gallery', :email => 'becca@quickleft.com', :password => 't8BncrHQ7sQ=', :password_confirmation => 't8BncrHQ7sQ='
user.confirmed_at = user.confirmation_sent_at
user.save
Role.create! :name => 'Admin'
Role.create! :name => 'Member'

user1 = User.find_by_email('becca@quickleft.com')
user1.role_ids = [1,2]
user1.save
