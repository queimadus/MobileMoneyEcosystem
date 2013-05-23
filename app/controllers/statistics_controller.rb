class StatisticsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index

    if current_user.is_client?
      if params[:kind]=="categories"
        client_statistics_categories
      elsif params[:kind]=="credit"
        client_statistics_credit
      end

    elsif  current_user.is_merchant?
      merchant_statistics #params
    else
      render :html => "lol"
    end
  end

  protected

  def client_statistics_categories
    from = params[:from_client] ? params[:from_client] : 1.month.ago.to_date
    to   = params[:to]   ? params[:to]   : Time.now.to_date
    #items = Item.joins(:categories).from(current_user.client).group("item.id, item.category_id").select("category.name as category_name, sum(actual_price) as total_price")
    #items = Item.joins("LEFT JOIN `categories` ON categories.id = items.category_id left join 'carts' on carts.id= items.cart_id").group("items.id, items.category_id").select("name as category_name, sum(actual_price) as total_price").where("client_id=?",1)
    #items = Item.between_dates(1.week.ago.to_date, Time.now.to_date).joins("LEFT JOIN `categories` ON categories.id = items.category_id left join 'carts' on carts.id= items.cart_id and carts.complete='t'")
    #.group("items.id, items.category_id").select("name as category_name, sum(actual_price) as total_price").where("client_id=?",current_user.client.id)

    render :json => category_prices_time(current_user.client.id,from,to)
  end

  def client_statistics_credit
    from = params[:from_client] ? params[:from_client] : 1.month.ago.to_date
    to   = params[:to]   ? params[:to]   : Time.now.to_date

    render :json => credit_time(current_user.client.id,from,to)
  end

  def credit_time(id,from,to)

    items = Item.between_dates(from, to).joins('INNER JOIN "carts" ON carts.id=items.cart_id')
    .group("date(items.updated_at)").select("date(items.updated_at) as updated_at, SUM(actual_price) AS total_price").where("client_id=?",id).where(:carts => {:complete => true})
    rows = []

    items.each do |i|
      rows << {:c => [{:v => i.updated_at.to_date.to_formatted_s(:short)},{:v => i.total_price.to_f}]}
    end

    {:cols => [{:label => "Month", :type => "string"},
               {:label => "Spent", :type => "number"}
    ],
     :rows => rows
     #:p => {:colors => colors}
    }

  end

  def category_prices_time(client_id, from, to)
    from ||=  1.month.ago.to_date
    to   ||=  Time.now.to_date

    items = Item.between_dates(from, to).joins('INNER JOIN "categories" ON categories.id = items.category_id INNER JOIN "carts" ON carts.id= items.cart_id')
    .group("items.category_id,categories.name,categories.color").select("name AS category_name, SUM(actual_price) AS total_price, color AS color").where("client_id=?",client_id).where(:carts => {:complete => true})
    rows = []
    colors = []
    items.each do |i|
      rows << {:c => [{:v => i.category_name},{:v => i.total_price.to_f}]}
      colors << "rgb("+i.color+")"
    end

    {:cols => [{:label => "Category", :type => "string"},
               {:label => "Money spent", :type => "number"}
              ],
     :rows => rows,
     :p => {:colors => colors}
    }
  end
end
