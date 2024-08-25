require 'csv'

puts "Importing business ideas..."

csv_file_path = Rails.root.join('db', 'business_ideas.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  BusinessIdea.create!(
    name: row['name'],
    average_revenue: row['average_revenue'].to_i,
    average_cost_to_start: row['average_cost_to_start'].to_i,
  )
end

puts "Imported #{BusinessIdea.count} business ideas."
