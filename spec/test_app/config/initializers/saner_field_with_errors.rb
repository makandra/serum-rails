# Configure a nicer display of validation errors in model forms.
# origin: RM
ActionView::Base.field_error_proc = proc do |inner_html, instance|
  "<span class='field_with_errors'>#{inner_html}</span>".html_safe
end
