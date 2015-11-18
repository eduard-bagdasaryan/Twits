# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = %W(Иванов Петров Сидоров Нельсон_Мандела Трус Балбес Бывалый)
i = 1
users.each do |u|
  tok = "tok_#{u}"
  user = User.create(name: u, token: tok)
  user.save
  i.times do
    v = rand(1..5)
    twit = user.twits.create(message: "#{u}_message_#{i}", vote: v)
    twit.save
  end
  i += 1
end
