class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index

    if current_user.is_client?
      if params[:kind]=="categories"
        client_statistics_categories
      elsif params[:kind]=="credit"
        client_statistics_credit
      else
        render "client_stats"
      end

    elsif  current_user.is_merchant?
      if params[:kind]=="categories"
        merchant_statistics_categories
      elsif params[:kind]=="credit"
        merchant_statistics_credit
      else
        render "merchant_stats"
      end
    else
      render :html => ""
    end
  end

  protected

  def merchant_statistics_categories
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => merchant_category_prices_time(current_user.merchant.id,from,to)
  end

  def client_statistics_categories
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => category_prices_time(current_user.client.id,from,to)
  end

  def client_statistics_credit
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => credit_time(current_user.client.id,from,to)
  end

  def merchant_statistics_credit
    from = params[:from] ? params[:from].to_date : 1.month.ago.to_date
    to   = params[:to]   ? params[:to].to_date   : Time.now.to_date
    render :json => merchant_credit_time(current_user.merchant.id,from,to)
  end

  def credit_time(id,from,to)

    items = Item.between_dates(from, to).joins('INNER JOIN "carts" ON carts.id=items.cart_id')
    .group("date(items.updated_at)").select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price")
    .where("client_id=?",id).where(:carts => {:complete => true})
    rows = []

    (from..to).each do |t|
      unless items.include?(t) {|i| i.updated_at}
         rows <<  {:c => [{:v => t.to_formatted_s(:short)},{:v => 0}]}
      end
    end

    items.each do |i|
      rows << {:c => [{:v => i.updated_at.to_date.to_formatted_s(:short)},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
    end

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

  def merchant_credit_time(id,from,to)

    items = Item.between_dates(from, to).joins('INNER JOIN "orders" ON orders.id=items.order_id')
    .group("date(items.updated_at)").select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price")
    .where("merchant_id=?",id)
    rows = []

    (from..to).each do |t|
      unless items.include?(t) {|i| i.updated_at}
        rows <<  {:c => [{:v => t.to_formatted_s(:short)},{:v => 0}]}
      end
    end

    items.each do |i|
      rows << {:c => [{:v => i.updated_at.to_date.to_formatted_s(:short)},{:v => sprintf("%.2f", i.total_price.to_f).to_f}]}
    end

    {:cols => [{:label => "Month", :type => "string"},
               {:label => "Sold", :type => "number"}
    ],
     :rows => rows,
     :p => { :from => from, :to => to}
    }

  end
end
