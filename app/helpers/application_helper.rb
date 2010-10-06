module ApplicationHelper
  def title(title_string = "")
    content_for(:title) { title_string }
  end

  def stylesheet(name = "")
    content_for(:stylesheet) { name }
  end

  def selected_class(condition, class1 = nil, class2 = nil)
    condition ? class1.to_s : class2.to_s
  end
end
