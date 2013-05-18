module MarketsHelper

  def draw_qrcode(product)
    tag("div", :class => "product-qrcode", :data => {:qrcode => product.qrcode})
  end

end
