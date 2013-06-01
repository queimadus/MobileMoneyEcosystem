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
mercearia = Category.create(:name => "groceries", :color => "127, 170, 129")
bebidas = Category.create(:name => "beverages", :color => "219, 171, 46")
higiene = Category.create(:name => "hygiene", :color => "200,202,219")
cleaning = Category.create(:name => "cleaning", :color => "236,165,228")
casa = Category.create(:name => "home", :color => "165,136,92")
congelados = Category.create(:name => "frozen", :color => "54,138,185")
fresco = Category.create(:name => "fresh", :color => "211,99,99")
dairy = Category.create(:name => "dairy", :color => "245,236,20")
lazer = Category.create(:name => "leisure", :color => "164,133,185")
outros = Category.create(:name => "others", :color => "182,182,182")

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

ip1=new_product("Desodorizante para homens","LIMPEX","6.19","25","axe.png",higiene,m)
ip2=new_product("Maca","Golden","1.2","6000","apple.png",mercearia,m)
ip3 = new_product("Espetadas","ILHAS","5","1","espetada.png",fresco,m)
ip4 = new_product("Shampoo para homens","SHAMPEX","5","124","shampoo.png",higiene,m)
ip5=new_product("Pepino","","1.5","543","pepino.png",mercearia,m)
ip6=new_product("Cotonetes","","1.9","6","cotonetes.png",higiene,m)
ip7=new_product("Cebola","","1.8","200","cebola.png",mercearia,m)
ip8=new_product("Broculos","ILHAS","1","200","broculos.png",mercearia,m)
ip9=new_product("Pimento","","3","512","pimentos.png",mercearia,m)
ip10=new_product("Alface","Verdinha","0.53","1000","alface.png",mercearia,m)
ip11=new_product("Frango Assado","ROAST","4","300","frango.png",fresco,m)
ip12=new_product("Tomate","TomatoSauce","0.86","300","tomate.png",mercearia,m)
ip13=new_product("Papel higienico","RELIMPA","3","100","papel.png",higiene,m)
ip14=new_product("Cenoura","Golden","1.33","33","CENOURA.png",mercearia,m)


#client
uu = User.new(:email => "c@c.c", :password => "bbbbbbbb")
c = Client.new(:first_name => "Paulo", :last_name => "Maia", :sex => "Male")
c.user = uu
uu.save
c.credit = 55
c.save

#Limits

def new_limit(max,period,cat,client)
  l = Limit.new(:max => max, :period => period)
  l.category = cat
  l.client = client
  l.save
end

lim1 = new_limit(20,"weekly",fresco,c)
lim2 = new_limit(50,"monthly",higiene,c)
lim3 = new_limit(50,"monthly",mercearia,c)

#Purchases

def new_cart(client)
cart = Cart.new()
cart.client = client
cart.save
end

cart1 = Cart.new()
cart1.client = c
cart1.save
cart2 = Cart.new()
cart2.client = c
cart2.save
cart3 = Cart.new()
cart3.client = c
cart3.save

#orders

order = Order.new()
order.merchant = m
order.save

order2 = Order.new()
order2.merchant =m
order2.save

order3 = Order.new()
order3.merchant = m
order3.save

#items
def new_item(pro,car,ord,qt)
  i = Item.new()
  i.product = pro
  i.quantity = qt
  i.actual_price = pro.price
  i.category_id = pro.categories.first.id
  i.cart= car
  i.order = ord
  i.save
end

def new_item1(pro,car,ord,qt)
  i = Item.new()
  i.product = pro
  i.quantity = qt
  i.actual_price = pro.price
  i.category_id = pro.categories.first.id
  i.cart= car
  i.order = ord
  #i.create_at =   "2013-05-21 18:14:06.754862"
  i.updated_at = "2013-05-21 18:15:06.754862"
  i.save
end

def new_item2(pro,car,ord,qt)
  i = Item.new()
  i.product = pro
  i.quantity = qt
  i.actual_price = pro.price
  i.category_id = pro.categories.first.id
  i.cart= car
  i.order = ord
 # i.create_at =   "2013-05-09 18:11:06.754862"
  i.updated_at = "2013-05-09 18:15:06.754862"
  i.save
end

item1 = new_item(ip1,cart1,order,1)
item2 = new_item(ip10,cart1,order,3)
item6 = new_item(ip6,cart1,order,1)
item10 = new_item(ip11,cart1,order,1)
item9 = new_item(ip4,cart1,order,3)

item3 = new_item1(ip2,cart2,order2,6)
item4 = new_item1(ip3,cart2,order2,2)
item5 = new_item1(ip13,cart2,order2,1)

order2.created_at =  "2013-05-21 19:15:06.754862"
order2.sent = true
order2.save

item7 = new_item2(ip4,cart3,order3,2)
item8 = new_item2(ip8,cart3,order3,3)

order3.created_at = "2013-05-09 19:14:06.754862"
order3.sent = true
order3.save

cart3.complete = true
#cart3.create_at = "2013-05-09 18:13:06.754862"
cart3.updated_at = "2013-05-09 18:14:06.754862"
cart3.save
cart2.complete = true
#cart3.create_at = "2013-05-21 18:15:06.754862"
cart2.updated_at = "2013-05-21 18:15:06.754862"
cart2.save

