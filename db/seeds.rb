City.destroy_all
User.destroy_all
Tag.destroy_all
Gossip.destroy_all
PrivateMessage.destroy_all

#Populate City DB
10.times do
   City.create!(city_name: Faker::Address.unique.city,
    zip_code: Faker::Address.zip)
end
puts "City seed Ok"

#Populate User DB
10.times do
   User.create!(first_name: Faker::Name.first_name, 
    last_name: Faker::Name.last_name, 
    description: Faker::Movies::Lebowski.quote,
    email: Faker::Internet.email,
    age: rand(18..65),
    city: City.find(City.first.id..City.last.id),
    password: rand(111111..222222).to_s
  )
end
puts "User seed Ok"

#Populate Tag DB
10.times do
  hash_tag = "#" + Faker::Lorem.unique.word
  Tag.create!(content: hash_tag)
end
puts "Tag seed Ok"

#Populate Gossip DB
20.times do
  Gossip.create!(title: Faker::Game.title,
    content: Faker::Movie.quote,
    user: User.find(User.first.id..User.last.id)
  )
end
puts "Gossip seed Ok"

#Populate linktabke Gossips/tags
Gossip.all.each do |gossip|
  rand(1..3).times do
    begin
      my_selected_tag = Tag.find(rand(Tag.first.id..Tag.last.id))
    end while gossip.tags.include?(my_selected_tag)
    gossip.tags << my_selected_tag
  end
end
puts "City/Tag link seed Ok"

# #Populate PrivateMessage DB
# 30.times do
#   PrivateMessage.create(
#     sender: User.find(User.first.id..User.last.id),
#     content: Faker::Movies::Lebowski.quote
#   )
# end

# #Populate linktabke PM/recipients
# PrivateMessage.all.each do |pm|
#     rand(1..3).times do
#     begin
#       my_selected_recipient = User.find(User.first.id..User.last.id)
#     end while pm.recipients.include?(my_selected_recipient) && my_selected_recipient == pm.sender
#     pm.recipients << my_selected_recipient
#   end
# end

#Populate Comment DB
Gossip.all.each do |gossip|
  rand(1..10).times do
    Comment.create(
      gossip: gossip,
      user: User.all.sample,
      content: Faker::Movies::StarWars.quote
    )
  end
end
puts "Comment seed Ok"