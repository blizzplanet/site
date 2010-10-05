module ApplicationHelper

  def selected_class(condition, class1 = nil, class2 = nil)
    condition ? class1.to_s : class2.to_s
  end
end
