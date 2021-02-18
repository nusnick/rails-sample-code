module SolutionsHelper
  #Display sort icon on solution list
  def sort_icon(current_field, sorted_field, direction)
    if current_field == sorted_field.to_sym
      arrow = (direction.downcase == "asc") ? "up" : "down"
      content_tag(:i, '', :class => "sort-icon glyphicon glyphicon-chevron-#{arrow}")
    end
  end

  def sortable_column(text, field, sorted_field, direction, params, type = 'solution')
    if sorted_field.to_sym == field
      new_direction = direction.downcase == "asc" ? "desc" : "asc"
    else
      new_direction = "asc"
    end
    if type == 'solution'
      return link_to text, solutions_path(params.merge(:sort_column => field, :direction => new_direction))
    else
      return link_to text, solution_specializations_path(params.merge(:sort_column => field, :direction => new_direction))
    end
  end
end
