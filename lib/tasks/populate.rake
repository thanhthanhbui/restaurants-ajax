namespace :populate do
  desc "Populates Restaurants"
  task rests: :environment do
    10.times do
      rest = Rest.create(
        name: Faker::Restaurant.name, 
        description: Faker::Restaurant.type
      )
      10.times do
        Food.create(dish: Faker::Food.dish, 
        description: Faker::Food.description, 
        rest_id: rest.id
      )
      end
    end
  end
end
