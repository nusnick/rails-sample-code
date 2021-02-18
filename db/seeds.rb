# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
%w(super_admin admin supervisor customer).each do |r|
  Role.create({"name" => r})
end
u = User.new({full_name: "SuperAdmin", email: "admin@example.com", password: '12345678', password_confirmation: '12345678'})
u.skip_confirmation!
u.save
u.add_role(:super_admin)