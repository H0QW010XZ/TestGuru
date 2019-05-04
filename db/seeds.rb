# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ruby, html, css = Category.create!([
    {title: 'Ruby'},
    {title: 'HTML'},
    {title: 'CSS'}
                                  ])

user_names = %w[Jenifer Arron Abe Max]

letters = ('a'..'z').to_a

user_names.map do |name|
  password = '123123'

  user = User.new({ email: "#{name}@test.com", password: password })
  user.skip_confirmation!
  user.save!
end

users = User.all

levels = (1..10).to_a

tests = Test.create!([{ title: 'Ruby basics', level: levels.sample, category: ruby, author_id: users.sample.id },
                      { title: 'Ruby advanced', level: levels.sample, category: ruby, author_id: users.sample.id },
                      { title: 'Ruby core', level: levels.sample, category: ruby, author_id: users.sample.id },
                      { title: 'HTML basics', level: levels.sample, category: html, author_id: users.sample.id },
                      { title: 'HTML forms', level: levels.sample, category: html, author_id: users.sample.id },
                      { title: 'HTML canvas', level: levels.sample, category: html, author_id: users.sample.id },
                      { title: 'CSS basics', level: levels.sample, category: css, author_id: users.sample.id },
                      { title: 'CSS flexbox', level: levels.sample, category: css, author_id: users.sample.id },
                      { title: 'CSS grid', level: levels.sample, category: css, author_id: users.sample.id }
                    ])

questions = 4
answers = 4

tests.each do |test|
  questions.times do |i|
    question = Question.create!(body: "#{test.title}, question #{i}", test_id: test.id)
    answers.times do |j|
      correct = j == 1
      Answer.create!(body: "Its a #{correct} answer for #{test.title}",
                    correct: correct,
                    question_id: question.id)
    end
  end
end

users.each do |user|
  tests.sample(4).each do |test|
    TestPassage.create!(score: rand(1..4), test_id: test.id, user_id: user.id)
  end
end

admin = Admin.new({ first_name: "qwe", last_name: "qwe", email: "admin@test.com", password: "123qwe123"} )
admin.skip_confirmation!
admin.save!

users.each do |user|
  2.times do
    question = Question.all.sample
    Gist.create!({ user: user, question: question, url: question })
  end
end
