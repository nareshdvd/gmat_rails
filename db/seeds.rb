# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin_user = User.create(email: "admin@gmatpro.com", password: "admin@123", password_confirmation: "admin@123")
passage_category = Category.create(title: "Passages", description: "Passage Questions category")
a_category = Category.create(title: "Category A", description: "Category A Questions category")
b_category = Category.create(title: "Category B", description: "Category B Questions category")
easy = Level.create(title: Level::EASY, description: "", question_score: 0.5)
medium = Level.create(title: Level::MEDIUM, description: "", question_score: 2)
tough = Level.create(title: Level::TOUGH, description: "", question_score: 5)
passage_question_count = 0
category_a_question_count = 0
category_b_question_count = 0
3.times do |inx_a|
  4.times do |inx_b|
    passage_question_count += 1
    question_group = QuestionGroup.create(description: "Passage Question Group #{passage_question_count}", category_id: passage_category.id)
    4.times do |inx_q|
      level_id = easy.id if inx_q == 0
      level_id = medium.id if [1, 2].include?(inx_q)
      level_id = tough.id if inx_q == 3
      question = question_group.questions.create(description: "#{question_group.description} - Question #{inx_q + 1}", option_count: 4, level_id: level_id)
      4.times do |inx_option|
        question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
      end
    end
  end

  25.times do |inx_b|
    category_a_question_count += 1
    question_group = QuestionGroup.create(description: "A Category Easy Question Group #{category_a_question_count}", category_id: a_category.id, level_id: easy.id)

    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: easy.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end

    question_group = QuestionGroup.create(description: "A Category Medium Question Group #{category_a_question_count}", category_id: a_category.id, level_id: medium.id)
    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: medium.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end

    question_group = QuestionGroup.create(description: "A Category Tough Question Group #{category_a_question_count}", category_id: a_category.id, level_id: tough.id)
    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: tough.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end

    question_group = QuestionGroup.create(description: "B Category Easy Question Group #{category_a_question_count}", category_id: b_category.id, level_id: easy.id)

    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: easy.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end

    question_group = QuestionGroup.create(description: "B Category Medium Question Group #{category_a_question_count}", category_id: b_category.id, level_id: medium.id)
    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: medium.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end

    question_group = QuestionGroup.create(description: "B Category Tough Question Group #{category_a_question_count}", category_id: b_category.id, level_id: tough.id)
    question = question_group.questions.create(description: "#{question_group.description} - Question 1", option_count: 4, level_id: tough.id)
    4.times do |inx_option|
      question.options.create(description: "#{question.description} - Option #{inx_option + 1}", is_correct: (true if inx_option == 0))
    end
  end
end
