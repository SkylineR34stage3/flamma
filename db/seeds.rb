# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do
  Category.create category: Faker::Hobby.activity
end

100.times do
  Post.create title: Faker::Lorem.sentence,
              subtitle: Faker::Lorem.sentence,
              bich_text: Faker::Lorem.paragraph,
              user_id: User.pluck(:id).sample,
              category_id: Category.pluck(:id).sample
end
