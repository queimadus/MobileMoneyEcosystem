module LimitsHelper

  def end_date(starting, period)
    unless starting.nil?
      if period=="weekly"
        starting + 1.week
      elsif period=="monthly"
        starting + 1.month
      else
        starting + 1.year
      end
    end
  end

  def time_percentage(starting, period)
    unless starting.nil?
      c = (Time.now.to_date-starting).to_i*100
      if period=="weekly"
        c / 7
      elsif period=="monthly"
        c / 31
      else
        c / 365
      end
    end
  end

  def product_percentage(limit)

    return 0 if limit.max==0

    if limit.period=="weekly"
      ending = limit.starting + 1.week
    elsif limit.period=="monthly"
      ending = limit.starting + 1.month
    elsif limit.period=="yearly"
      ending = limit.starting + 1.year
    end


    a = Item.where(:category_id => limit.category.id ,:cart_id => Cart.where(:complete => true, :client_id => limit.client_id ).date_between(limit.starting,ending)).sum(:actual_price)
    b = limit.max/100.0
    number_with_precision(a/b, :precision => 0)
    #53
  end

  def bar_color(p)
    style = " background-image:none; background-color:"
    if p.to_i >= 85
      style += "#b94a48;"
    end

    style
  end

end
