class UserBadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def give_badges
    Badge.all.select { |badge| badge if send("#{badge.criterion}?".to_sym, badge.param) }
  end

  private

  def all_level?(level)
    return if @test.level != level.to_i

    level_tests_ids = Test.where(level: level.to_i).ids.sort
    level_tests_ids == successful_tests_by_level(level).ids.sort
  end

  def all_category?(category_id)
    return if @test.category != category_id

    cat_tests_ids = Test.where(category_id: category_id).ids.sort
    cat_tests_ids == successful_tests_by_category(category_id).ids.sort
  end

  def first_try?(id)
    id == @test.id && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_tests_by_level(level)
    successful_tests_by_user.where(level: level)
  end

  def successful_tests_by_category(category_id)
    successful_tests_by_user.where(category_id: category_id)
  end

  def successful_tests_by_user
    Test.joins(:test_passages).where("test_passages.result >= ? and test_passages.user_id = ?", TestPassage::SUCCESS_PERCENTAGES, @user.id)
  end

end
