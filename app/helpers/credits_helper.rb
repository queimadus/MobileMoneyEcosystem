module CreditsHelper

  def error_messages(result,sub,down)

    if !result.nil? and !result.errors.nil?
      message = []
      if down==:amount
        arr = result.errors.for(:transaction).on(down)
      else
        arr = result.errors.for(:transaction).for(sub).on(down)
      end

      arr.each do |a|
        message << content_tag(:span, a.message, :class => "form-error-label")
      end
      path=""
      message.uniq.each{|s| path << s }
      path.html_safe
    end

  end
end
