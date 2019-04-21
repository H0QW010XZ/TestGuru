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

    level_tests_ids = Test.where(level: level.to_i).ids.uniq.sort
    level_tests_ids == successful_tests_by_level(level).ids
  end

  def all_category?(category_id)
    return if @test.category != category_id

    cat_tests_ids = Test.where(category_id: category_id).ids.uniq.sort
    cat_tests_ids == successful_tests_by_category(category_id).ids
  end

  def first_try?(id)
    id == @test.id && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_tests_by_level(level)
    Test.joins(:test_passages).where("test_passages.result >= ? and user_id = ?", TestPassage::SUCCESS_PERCENTAGES, @user.id)
        .where(level: level)
  end

  def successful_tests_by_category(category_id)
    Test.joins(:test_passages).where("test_passages.result >= ? and user_id = ?", TestPassage::SUCCESS_PERCENTAGES, @user.id)
        .where(category_id: category_id)
  end
end
