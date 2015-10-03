Order.transaction do
  (1..100).each do |i|
    Order.create(:name => "老王 #{i} 号", :address => "第 #{i} 大街", :email => "customer-#{i}@example.com", :pay_type => "月结")
  end
end