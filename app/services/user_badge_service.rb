class UserBadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def give_badges
    return [] unless @test_passage.successful?

    Badge.all.select do |badge|
      send("#{badge.criterion}?".to_sym, badge.param)
    end
  end

  private

  def all_level?(level_id)
    if @test.level == level_id.to_i
      level_tests_ids = Test.where(level: level_id).ids.uniq.sort
      level_tests_ids == successful_user_tests_ids
    end
  end

  def all_category?(category_id)
    if @test.category.id == category_id.to_i
      cat_tests_ids = Category.find(category_id).tests.ids.uniq.sort
      cat_tests_ids == successful_user_tests_ids
    end
  end

  def first_try?(test_id)
    (test_id.to_i.zero? || test_id.to_i == @test.id) && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_user_tests_ids
    @user.test_passages.where("result >= ?", TestPassage::SUCCESS_PERCENTAGES).select(:id, :test_id).distinct.order(:test_id).pluck(:test_id)
  end
end
