module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "success"
    when :error then "danger"
    when :alert then "warning"
    end
  end

  #Render model errors when submitting a form
  def form_errors(object)
    unless object.errors.empty?
      html = content_tag(:div, class: "row") do
        content_tag(:div, class: "col-md-12") do
          content_tag(:div, class: "alert alert-dismissable alert-danger") do
            #content_tag(:button, "&times;", type: "button", class: "close", "data-dismiss": "alert", "aria-hidden": true)
            html = '<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'
            object.errors.full_messages.each do |m|
              html += "#{m}.<br />"
            end
            html.html_safe
          end
        end
      end
    end
  end

  def link_to_function(name, *args, &block)
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ''
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'

    content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick, :class => "action-field-link"))
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)

    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end

  #handle display long string
  def display_long_string(string, max_length)
    if (string.nil? || string.strip.length <= max_length)
      return string
    else
      return string.strip[0..max_length] + "..."
    end
  end

  def form_control_wrapper(options = {}, &block)
    content = capture(&block)
    content_tag(:div, class: 'row') do
      content_tag(:div, {class: "col-md-12"}.merge(options)) do
        content
      end
    end
  end
end
