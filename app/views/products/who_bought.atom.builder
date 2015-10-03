atom_feed do |feed|
  feed.title "购买 #{@product.title} 的用户"

  latest_order = @product.orders.sort_by(&:update_at).last
  feed.updated( latest_order && latest_order.update_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary :type => 'xhtml' do |xhtml|
        xhtml.p "发往 #{order.address}"
        xhtml.table do
          xhtml.tr do
            xhtml.th '菜品'
            xhtml.th '数量'
            xhtml.th '总价'
          end

          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.total_price
            end
          end

          xhtml.tr do
            xhtml.th '合计', :colspan => 2
            xhtml.th number_to_currency order.line_items.map(&:total_price).sum
          end
        end

        xhtml.p "支付方式 #{order.pay_type}"
      end

      entry.author do |author|
        entry.name order.name
        entry.email order.email
      end
    end
  end
end