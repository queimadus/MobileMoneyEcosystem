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

  def error_on_form(resource, hash)
      text = []
      resource[hash].each do |t|
        text << content_tag(:span, t, :class => "form-error-label")
      end
    text.uniq.join("<br>").html_safe
  end

  def red_asterisk
    content_tag(:span,'*', :class => "red-asterisk")
  end

end
