class UserBadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def give_badges
    Badge.all.select do |badge|
      send("#{badge.criterion}?".to_sym, badge.param)
    end
  end

  def check_badge(badge, user)
    if send(badge.criterion.to_sym, badge.param.to_i)
      user.user_badges.push(badge)
    end
  end

  private

  def all_level?(level)
    return if @test.level != level

    level_tests_ids = Test.where(level: level).ids.sort
    level_tests_ids == successful_user_tests.where(level: level).ids
  end

  def all_category?(id)
    return if @test.category != id

    cat_tests_ids = Test.where(category_id: id).ids.sort
    cat_tests_ids == successful_user_tests.where(category_id: id).ids
  end

  def first_try?(id)
    (id.zero? || id == @test.id) && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_user_tests
    @user.test_passages.where("result >= ?", TestPassage::SUCCESS_PERCENTAGES).order(:test_id)
  end
end
