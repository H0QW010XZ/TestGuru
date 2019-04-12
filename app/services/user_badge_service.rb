class UserBadgeService
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
    @test = test_passage.test
  end

  def give_badges
    Badge.all.each do |badge|
      if send("#{badge.criterion}?".to_sym, badge.param)
        @user.badges.push(badge)
      end
    end
  end

  private

  def all_level?(level)
    return if @test.level != level.to_i

    level_tests_ids = Test.where(level: level.to_i).ids.uniq.sort
    level_tests_ids == successful_user_tests
  end

  def all_category?(id)
    return if @test.category != id

    cat_tests_ids = Test.where(category_id: id).ids.uniq.sort
    cat_tests_ids == successful_user_tests
  end

  def first_try?(id)
    (id.zero? || id == @test.id) && not_passed_before?(@test)
  end

  def not_passed_before?(test)
    @user.test_passages.where(test: test).count == 1
  end

  def successful_user_tests
    @user.test_passages.where("result >= ?", TestPassage::SUCCESS_PERCENTAGES).order(:test_id).pluck(:test_id)
  end
end
