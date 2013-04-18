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
    54
  end

end
