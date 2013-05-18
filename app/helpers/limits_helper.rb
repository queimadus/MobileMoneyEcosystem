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

  def time_percentage(limit)
    limit.time_percentage
  end

  def product_percentage(limit)

    number_with_precision(limit.credit_percentage, :precision => 0)
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
