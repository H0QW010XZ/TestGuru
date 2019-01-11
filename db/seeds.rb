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

users = user_names.map { |name| User.create!(name: name) }

tests = Test.create!([{ title: 'Ruby basics', level: 0, category_id: ruby.id },
                     { title: 'Ruby advanced', level: 1, category_id: ruby.id },
                     { title: 'Ruby core', level: 2, category_id: ruby.id },
                     { title: 'HTML basics', level: 0, category_id: html.id },
                     { title: 'HTML forms', level: 0, category_id: html.id },
                     { title: 'HTML canvas', level: 1, category_id: html.id },
                     { title: 'CSS basics', level: 0, category_id: css.id },
                     { title: 'CSS flexbox', level: 1, category_id: css.id },
                     { title: 'CSS grid', level: 1, category_id: css.id }
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
    Result.create!(score: rand(1..4), test_id: test.id, user_id: user.id)
  end
end