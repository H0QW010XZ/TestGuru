module BadgesHelper
  def criterions_collection
    Badge.criterions.map {|item, _val| [t("admin.badges.#{item}"), item]}
  end

  def tests_with_any
    [[0, t('admin.badges.any')]] + @tests.pluck(:id, :title)
  end
end
