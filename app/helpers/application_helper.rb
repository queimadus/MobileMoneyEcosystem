module ApplicationHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = :success if type == :notice
      type = :error   if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div,
                           content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                               msg.html_safe, :class => "inline alert fade in alert-#{type}")
        flash_messages << text if message
      end
    end
    flash_messages.join("\n").html_safe
  end

  def period_to_date(period)
    if period=="weekly"
      1.week
    elsif period=="monthly"
      1.month
    elsif  period=="yearly"
      1.year
    else
      0.day
    end
  end

  def bootstrap_notice(msg,type)
    flash_messages = []


      type = :success if type == :notice
      type = :error   if type == :alert


        text = content_tag(:div,
                           content_tag(:button, ("&times;").html_safe, :class => "close", "data-dismiss" => "alert-notice") +
                               msg.html_safe, :class => "inline alert alert-notice fade in alert-#{type}")
        flash_messages << text


    flash_messages.join("\n").html_safe
  end

  def error_on_form(a, hash)
      text = []
      a[hash].each do |t|
        text << content_tag(:span, t, :class => "form-error-label")
      end
    text.uniq.join("<br>").html_safe
  end

  def error_on_form_text(a)
    text = []

    a.full_messages.each do |t|
      text << content_tag(:span, t)
    end
    text.uniq.join("<br>").html_safe
  end

  def red_asterisk
    content_tag(:span,'*', :class => "red-asterisk")
  end

  def three_dots(options = {})
    text = options[:horizontal]? "three-dots horizontal" : "three-dots"
    content_tag :div, :class => text do
      content_tag(:div,"") +
      content_tag(:div,"") +
      content_tag(:div,"")
    end
  end

  def category_color(attr,obj)
    if obj.instance_of?(Product)
      color = obj.categories.first.color
    elsif
      color = obj.category.color
    end

    ret = 'style='
    attr.split(",").each do |a|

      ret+= a+':rgb('+color+');'
    end

    ret
  end

  def qrcode_image_for(product, options = {})
    #TODO still a stub. needs to convert a product qrcode token into a qrcodeIMAGE url or somthing
    image_tag "http://www.qrpix.com/blog/wp-content/uploads/2012/11/QR-code.jpg", options
  end

  def active(path)
   return " active" if current_page?(path)
    ""
  end

  def all_categories
    cat=[]
    Category.all.each do |c|
      cat << c.name
    end
    cat
  end

end
