# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


c1 = Client.create(:email => "bruno@fe.up.pt", :password => "bbbbbbbb")
m1 = Merchant.create(:email => "paulo@fe.up.pt", :password => "bbbbbbbb")

p1 = Product.new(:name => "Produto Um", :available => true, :price => "300")
p2 = Product.new(:name => "Produto Dois", :available => true, :price => "600")



