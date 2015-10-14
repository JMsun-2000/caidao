json.array!(@customer_infos) do |customer_info|
  json.extract! customer_info, :id, :user_id, :real_name, :comment_info, :phone_number, :resturant_address, :identify_number
  json.url customer_info_url(customer_info, format: :json)
end
