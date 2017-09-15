module ApplicationHelper

  def is_enabled?(status)
    status == 1 ? "Enabled" : "Disabled"
  end

end
