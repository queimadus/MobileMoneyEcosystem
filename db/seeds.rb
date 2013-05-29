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
mercearia = Category.create(:name => "groceries", :color => "79,128,79")
bebidas = Category.create(:name => "beverages", :color => "223,32,32")
higiene = Category.create(:name => "hygiene", :color => "161,164,194")
cleaning = Category.create(:name => "cleaning", :color => "175,190,0")
casa = Category.create(:name => "home", :color => "79,128,79")
congelados = Category.create(:name => "frozen", :color => "223,32,32")
fresco = Category.create(:name => "fresh", :color => "223,32,32")
dairy = Category.create(:name => "dairy", :color => "161,164,194")
lazer = Category.create(:name => "leisure", :color => "175,190,0")
outros = Category.create(:name => "others", :color => "79,128,79")

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
  p
end

(1..50).each do |i|
  p1 = Product.new(:name => "Produto "+i.to_s, :price => (i*2).to_s)
  if i < 12
    p1.categories << mercearia
  elsif i<24
    p1.categories << fresco
  elsif i<36
    p1.categories << bebidas
  else
    p1.categories << dairy
  end
  p1.merchant = m
  p1.set_hash
  p1.save
end

ip1=new_product("Desodorizante para homens","AXE","6.19","25","axe.png",higiene,m)
ip2=new_product("Maca","Golden","1.2","6000","apple.png",mercearia,m)
ip3 = new_product("Espetadas","Continente","5","1","espetada.png",fresco,m)
ip4 = new_product("Shampoo para homens","Pantene","5","124","shampoo.png",higiene,m)
ip5=new_product("Pepino","","1.5","543","pepino.png",mercearia,m)
ip6=new_product("Cotonetes","","1.9","6","cotonetes.png",higiene,m)
ip7=new_product("Cebola","","1.8","200","cebola.png",mercearia,m)
ip8=new_product("Broculos","Continente","1","200","broculos.png",mercearia,m)
ip9=new_product("Pimento","","3","512","pimentos.png",mercearia,m)
ip10=new_product("Alface","Verdinha","0.53","1000","alface.png",mercearia,m)
ip11=new_product("Frango Assado","Dom Brasas","4","300","frango.png",fresco,m)
ip12=new_product("Tomate","TomatoSauce","0.86","300","tomate.png",mercearia,m)
ip13=new_product("Papel higienico","Renova","3","100","papel.png",higiene,m)
ip14=new_product("Cenoura","Golden","1.33","33","CENOURA.png",mercearia,m)


#Limits

uu = User.new(:email => "c@c.c", :password => "bbbbbbbb")
c = Client.new(:first_name => "Paulo", :last_name => "Maia", :sex => "Male")
c.user = uu
uu.save
c.save
=begin
l = Limit.new(:max => 20, :period => "weekly")
l.category = vegetais
l.client = c
l.save
=end
#purchases

def new_item(pro,car,ord)
  i = Item.new()
  i.product = pro
  i.quantity = 1
  i.actual_price = pro.price
  i.category_id = pro.categories.first.id
  i.cart=car
  i.order = ord
  i.save
end
=begin
cart = Cart.new(:complete => true)
cart.client = c
cart.save

order = Order.new
order.merchant = m
order.save

new_item(ip1,cart,order)
new_item(ip2,cart,order)
new_item(ip3,cart,order)
new_item(ip4,cart,order)
new_item(ip5,cart,order)
new_item(ip6,cart,order)

cart = Cart.new(:complete => true)
cart.client = c
cart.save

order = Order.new
order.merchant = m
order.save

new_item(ip7,cart,order)
new_item(ip8,cart,order)
new_item(ip9,cart,order)

cart = Cart.new(:complete => true)
cart.client = c
cart.save

order = Order.new
order.merchant = m
order.save

new_item(ip10,cart,order)
new_item(ip11,cart,order)
new_item(ip12,cart,order)

cart = Cart.new(:complete => true)
cart.client = c
cart.save

order = Order.new
order.merchant = m
order.save

new_item(ip13,cart,order)
new_item(ip14,cart,order)
=end


