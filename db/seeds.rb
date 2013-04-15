# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#merchant
u = User.new(:email => "m@m.m", :password => "bbbbbbbb")
m = Merchant.new(:name => "Bruno")
m.user = u
u.save
m.save

#categories
vegetais = Category.create(:name => "Vegetais", :color => "79,128,79")
assados = Category.create(:name => "Assados", :color => "223,32,32")
higiene = Category.create(:name => "Higiene", :color => "161,164,194")
fruta = Category.create(:name => "Fruta", :color => "175,190,0")

#products

def new_product(name, brand, price, stock, img, cat, merc)
  p = Product.new(:name => name, :price => price, :brand => brand, :stock => stock)
  p.categories << cat
  p.merchant = merc
  file = File.open(Rails.root.join('app', 'assets', 'images','seeds',img))
  p.image = file
  p.set_hash
  file.close
  p.save
end

(1..50).each do |i|
  p1 = Product.new(:name => "Produto "+i.to_s, :price => (i*2).to_s)
  if i < 12
    p1.categories << vegetais
  elsif i<24
    p1.categories << assados
  elsif i<36
    p1.categories << higiene
  else
    p1.categories << fruta
  end
  p1.merchant = m
  p1.set_hash
  p1.save
end

new_product("Desodorizante para homens","AXE","6.19","25","axe.png",higiene,m)
new_product("Maca","Golden","1.2","6000","apple.png",vegetais,m)
new_product("Espetadas","Continente","5","1","espetada.png",assados,m)
new_product("Shampoo para homens","Pantene","5","124","shampoo.png",higiene,m)
new_product("Pepino","","1.5","543","pepino.png",vegetais,m)
new_product("Cotonetes","","1.9","6","cotonetes.png",higiene,m)
new_product("Cebola","","1.8","200","cebola.png",vegetais,m)
new_product("Broculos","Continente","1","200","broculos.png",vegetais,m)
new_product("Pimento","","3","512","pimentos.png",vegetais,m)
new_product("Alface","Verdinha","0.53","1000","alface.png",vegetais,m)
new_product("Frango Assado","Dom Brasas","4","300","frango.png",assados,m)
new_product("Tomate","TomatoSauce","0.86","300","tomate.png",vegetais,m)
new_product("Papel higienico","Renova","3","100","papel.png",higiene,m)
new_product("Cenoura","Golden","1.33","33","CENOURA.png",vegetais,m)


#Limits

uu = User.new(:email => "c@c.c", :password => "bbbbbbbb")
c = Client.new(:first_name => "Paulo", :last_name => "Maia", :sex => "Male")
c.user = uu
uu.save
c.save

l = Limit.new(:max => 20, :period => "weekly")
l.category = vegetais
l.client = c
l.save






