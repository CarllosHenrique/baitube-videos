module ApplicationHelper
  def danger_error_form(model, attribute)
    model.errors.messages_for(attribute).map do |message|
      content_tag(:div, message, class: "alert alert-danger", role: "alert")
    end.join.html_safe
  end
end
