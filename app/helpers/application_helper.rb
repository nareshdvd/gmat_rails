module ApplicationHelper

  def col_sm(column, &block)
    content = capture(&block)
    ctag = content_tag(:div, content, class: "col-sm-#{column}")
    content_tag(:div, ctag, class: "row")
  end

  def col_sm_offset(column, offset, &block)
    content = capture(&block)
    ctag = content_tag(:div, content, class: "col-sm-#{column} col-sm-offset-#{offset}")
    content_tag(:div, ctag, class: "row")
  end
end
