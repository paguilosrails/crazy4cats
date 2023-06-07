# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email:"admin@correo.cl", username: "Admin", role: 2, password: "123456", password_confirmation: "123456")
User.create(email:"correo@correo.cl", username: "correo1", role: 0, password: "123456", password_confirmation: "123456")

i = 0
until User.count == 20 do
User.create(email: "test#{i}@gmail", username: "usuario#{i}", password: "asdasdasd", password_confirmation: "asdasdasd")
i += 1
end

10.times do |i|
    user = User.all.sample
    Publication.create(image: Faker::Placeholdit.image, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph, user_id: user.id)
end

publication = Publication.all
users = User.all

until Comment.count == 10 do
  Comment.create(
    content: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false),
    publication_id: publication.sample.id,
    user_id: users.sample.id
  )
end

r_type = %w[publication comment]
comments = Comment.all
kinds = Publication::Kinds

until Reaction.count == 10 do
  rel_type = r_type.sample
  if rel_type == "publication"
    Reaction.create(
      publication_id: publication.sample.id,
      user_id: users.sample.id,
      kind: kinds.sample,
      reaction_type: rel_type
    )
  end
end