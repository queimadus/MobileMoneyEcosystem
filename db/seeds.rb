# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
m = Merchant.new(:name => "Bruno")
m.user = u
u.save
m.save

cat1 = Category.create(:name => "Vegetais", :color => "0,128,0")
cat2 = Category.create(:name => "Assados", :color => "128,0,0")
cat3 = Category.create(:name => "Higiene", :color => "0,0,128")
cat4 = Category.create(:name => "Fruta", :color => "64,0,64")


(1..50).each do |i|
  p1 = Product.new(:name => "Produto "+i.to_s, :price => (i*2).to_s, :qrcode => i.to_s)
  if i < 12
    p1.categories << cat1
  elsif i<24
    p1.categories << cat2
  elsif i<36
    p1.categories << cat3
  else
    p1.categories << cat4
  end
  p1.merchant = m
  p1.save
end


