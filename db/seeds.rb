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
c.credit = 150
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
i1 = Product.find(1).add_to_cart c,2
i2 = Product.find(2).add_to_cart c,3

i3 = Product.find(3).add_to_cart c,1

i4 = Product.find(4).add_to_cart c,1

i5 = Product.find(5).add_to_cart c,3


Cart.buy_from_client c
c1 = Cart.find(1)
c1.updated_at= "2013-05-09 18:15:06.754862"
c1.save
o1 = Order.find(1)
o1.created_at =  "2013-05-09 18:15:06.754862"
o1.save
it1 = Item.find(1)
it1.updated_at = "2013-05-09 18:15:06.754862"
it1.save
it2 = Item.find(2)
it2.updated_at = "2013-05-09 18:16:06.754862"
it2.save
it3 = Item.find(3)
it3.updated_at = "2013-05-09 18:17:06.754862"
it3.save
it4 = Item.find(4)
it4.updated_at = "2013-05-09 18:18:06.754862"
it4.save
it5 = Item.find(5)
it5.updated_at = "2013-05-09 18:15:06.754862"
it5.save


i6 = Product.find(6).add_to_cart c,1

i7 = Product.find(7).add_to_cart c,3

i8 = Product.find(8).add_to_cart c,1

i9 = Product.find(9).add_to_cart c,2

i10 = Product.find(10).add_to_cart c,1

Cart.buy_from_client(c)

c2 = Cart.find(2)
c2.updated_at= "2013-05-14 18:15:06.754862"
c2.save
o6 = Order.find(2)
o6.created_at =  "2013-05-14 18:15:06.754862"
o6.save

it6 = Item.find(6)
it6.updated_at = "2013-05-14 18:15:06.754862"
it6.save
it7 = Item.find(7)
it7.updated_at = "2013-05-14 18:15:06.754862"
it7.save
it8 = Item.find(8)
it8.updated_at = "2013-05-14 18:15:06.754862"
it8.save
it9 = Item.find(9)
it9.updated_at = "2013-05-14 18:15:06.754862"
it9.save
it10 = Item.find(10)
it10.updated_at = "2013-05-14 18:15:06.754862"
it10.save


i11 = Product.find(4).add_to_cart c,2

i12 = Product.find(2).add_to_cart c,3

i13 = Product.find(7).add_to_cart c,1

Cart.buy_from_client(c)
c3 = Cart.find(3)
c3.updated_at= "2013-05-23 18:15:06.754862"
c3.save
o11 = Order.find(3)
o11.created_at =  "2013-05-23 18:15:06.754862"
o11.save

it11 = Item.find(11)
it11.updated_at = "2013-05-23 18:15:06.754862"
it11.save
it12 = Item.find(12)
it12.updated_at = "2013-05-23 18:16:06.754862"
it12.save
it13 = Item.find(13)
it13.updated_at = "2013-05-23 18:17:06.754862"
it13.save


i11 = Product.find(8).add_to_cart c,1
i12 = Product.find(4).add_to_cart c,3
i13 = Product.find(9).add_to_cart c,1
