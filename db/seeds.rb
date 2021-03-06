# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# PublicActivity.enabled = false

Lesson.destroy_all
Course.destroy_all
User.destroy_all

# User.create!(email: 'admin@example.com', password: 'admin@example.com', password_confirmation: 'admin@example.com')
languages = [ "English", "Czech", "Russian"]
levels = [ "Beginner", "Intermediate","Advanced"]

user = User.new(
  email: 'admin@example.com', 
  password: 'admin@example.com', 
  password_confirmation: 'admin@example.com'
)
user.skip_confirmation!
user.save!

user_student = User.new(
  email: 'student@example.com', 
  password: 'student@example.com', 
  password_confirmation: 'student@example.com'
)
user_student.skip_confirmation!
user_student.save!

30.times do
  Course.create!([{
    title: Faker::Educator.course_name,
    language: Faker::Nation.language,
    price: rand(20..55),
    level: levels.sample,
    short_description: Faker::Quote.robin,
    description: Faker::TvShows::GameOfThrones.quote,
    user_id: User.first.id
  }])
end

