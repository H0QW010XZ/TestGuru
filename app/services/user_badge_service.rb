class UserBadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def give_badges
    Badge.all.map { |badge| badge if send("#{badge.criterion}?".to_sym, badge.param) }
  end

  private

  def all_level?(level)
    return if @test.level != level.to_i

    level_tests_ids = Test.where(level: level.to_i).ids.uniq.sort
    level_tests_ids == TestPassage.successful_tests_by_level(level).ids
  end

  def all_category?(id)
    return if @test.category != id

    cat_tests_ids = Test.where(category_id: id).ids.uniq.sort
    cat_tests_ids == TestPassage.successful_tests_by_category(id).ids
  end

  def first_try?(id)
    id == @test.id && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end
end
