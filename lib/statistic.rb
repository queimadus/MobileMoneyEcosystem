module Statistic
  def credit_time(id,from,to,cat)

    items = Item.between_dates(from, to).joins('INNER JOIN "carts" ON carts.id=items.cart_id')
    .where("client_id=?",id).where(:carts => {:complete => true})

    if !cat.nil? and cat.to_i!=0
      items = items.select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price, Items.category_id AS category_id")
      .where(:category_id => cat.to_i).group("date(items.updated_at), items.category_id")
    else
      items = items.select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price")
      .group("date(items.updated_at)")
    end

    rows = []

    (from..to).each do |t|
      unless items.any? {|i| i.updated_at.to_date==t}
        rows <<  {:c => [{:v => t.to_formatted_s(:short)},{:v => 0}]}
      end
    end

    items.each do |i|
        rows << {:c => [{:v => i.updated_at.to_date.to_formatted_s(:short)},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
    end

    rows = rows.sort_by {|e| e[:c][0][:v]}

    {:cols => [{:label => "Month", :type => "string"},
               {:label => "Spent", :type => "number"}
    ],
     :rows => rows,
     :p => { :from => from, :to => to}
    }

  end

  def category_prices_time(client_id, from, to)
    from ||=  1.month.ago.to_date
    to   ||=  Time.now.to_date

    items = Item.between_dates(from, to)
    .joins('INNER JOIN "categories" ON categories.id = items.category_id INNER JOIN "carts" ON carts.id= items.cart_id')
    .group("items.category_id,categories.name,categories.color")
    .select("name AS category_name, SUM(actual_price) AS total_price, color AS color")
    .where("client_id=?",client_id).where(:carts => {:complete => true})

    rows = []
    colors = []
    items.each do |i|
      rows << {:c => [{:v => i.category_name},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
      colors << "rgb("+i.color+")"
    end

    {:cols => [{:label => "Category", :type => "string"},
               {:label => "Money spent", :type => "number"}
    ],
     :rows => rows,
     :p => {:colors => colors, :from => from, :to => to}
    }
  end

  def merchant_category_prices_time(client_id, from, to)
    from ||=  1.month.ago.to_date
    to   ||=  Time.now.to_date

    items = Item.between_dates(from, to)
    .joins('INNER JOIN "categories" ON categories.id = items.category_id INNER JOIN "orders" ON orders.id= items.order_id')
    .group("items.category_id,categories.name,categories.color")
    .select("name AS category_name, SUM(actual_price) AS total_price, color AS color")
    .where("merchant_id=?",client_id)

    rows = []
    colors = []
    items.each do |i|
      rows << {:c => [{:v => i.category_name},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
      colors << "rgb("+i.color+")"
    end

    {:cols => [{:label => "Category", :type => "string"},
               {:label => "Credit", :type => "number"}
    ],
     :rows => rows,
     :p => {:colors => colors, :from => from, :to => to}
    }
  end

  def merchant_credit_time(id,from,to,cat)

    items = Item.between_dates(from, to).joins('INNER JOIN "orders" ON orders.id=items.order_id')
    .where("merchant_id=?",id)

    if !cat.nil? and cat.to_i!=0
      items = items.select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price, Items.category_id AS category_id")
          where("category_id = ?", cat.to_i).group("date(items.updated_at), items.category_id")
    else
      items = items.select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price")
          .group("date(items.updated_at)")
    end

    rows = []

    (from..to).each do |t|
      unless items.any? {|i| i.updated_at.to_date==t}
        rows <<  {:c => [{:v => t.to_formatted_s(:short)},{:v => 0}]}
      end
    end

    items.each do |i|
        rows << {:c => [{:v => i.updated_at.to_date.to_formatted_s(:short)},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
    end

    rows = rows.sort_by {|e| e[:c][0][:v]}

    {:cols => [{:label => "Month", :type => "string"},
               {:label => "Sold", :type => "number"}
    ],
     :rows => rows,
     :p => { :from => from, :to => to}
    }

  end
end