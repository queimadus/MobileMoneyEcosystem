module HistoriesHelper

  def filter_categories(product,categories)
      if(categories.nil?)
        return true
      end
      categories.include?(product.categories.first)
  end

  def join_orders_by_date(c,categories)
    content = ""
    price = 0
    date=""
    #c.each do |grp|
#.select("items.*, SUM(items.quantity) as quantity")
      a = Item.select("items.*, sum(quantity) as sum_quantity").where(:order_id => c).order("category_id").group(:product_id, :id)
      a.each_with_index do |i,index|
        if filter_categories(i.product, categories)
          content << render('histories/merchant_product', item: i)
          price += i.actual_price
        end

        if index==0
          date=i.updated_at.to_date
        end
      end
    #end

    {:content => content, :price => price, :date => date}
  end
end
