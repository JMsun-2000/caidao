module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def number_to_rmb(number)
    return "￥#{number_with_precision(number, :precision => 2)}"
  end
end

