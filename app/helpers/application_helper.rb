module ApplicationHelper
  def dtf date
    return '' if date.blank?

    date.strftime('%D')
  end
end
