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

  def all_level?(id)
    return if @test.level != id.to_i

    level_tests_ids = Test.where(level: level_id.to_i).ids.count
    level_tests_ids == successful_user_tests
  end

  def all_category?(category_id)
    cat_tests_ids = Category.find(category_id.to_i).tests.ids.count
    cat_tests_ids == successful_user_tests
  end

  def first_try?(test_id)
    (test_id.to_i.zero? || test_id.to_i == @test.id) && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_user_tests
    @user.test_passages.select(&:successful?)
  end
end
