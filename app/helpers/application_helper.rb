module ApplicationHelper
  FLASH_KEYS = { notice: 'alert-primary', alert: 'alert-danger', success: 'alert-success' }.freeze
  def current_year
    Time.current.year
  end

  def flash_msg(key)
    FLASH_KEYS[key.to_sym]
  end
end
