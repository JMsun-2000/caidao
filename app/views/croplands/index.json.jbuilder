json.array!(@croplands) do |cropland|
  json.extract! cropland, :id, :user_id, :land_area, :area_unit, :land_production, :land_output, :output_unit, :output_cycle, :latest_seeding_date, :product_id
  json.url cropland_url(cropland, format: :json)
end
