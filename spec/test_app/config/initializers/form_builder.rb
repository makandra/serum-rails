# Controls and helpers for forms.
# origin: RM
ActionView::Helpers::FormBuilder.class_eval do

  def partial(name, locals = {})
    @template.render name, locals.merge(:form => self)
  end
  
  def check_box_list(field, choices, options = {})
    html = ""
    name = nil
    choices.each do |choice, label|
      html << '<div class="check_box_with_label">'
      name = "#{object_name}[#{field}][]"
      id = "#{name}_#{choice}".gsub(/[^a-z0-9]/i, '_')
      checked = object.send(field).include?(choice)
      html << @template.check_box_tag(name, choice, checked, :id => id)
      html << @template.label_tag(id, ERB::Util.html_escape(label || choice))
      html << '</div>'
    end
    html << @template.hidden_field_tag(name, '') unless options[:allow_empty] # cannot serialize an empty list
    html.html_safe
  end

  def error_message_on(attr)
    message = Error.message(object, attr)
    @template.content_tag(:div, message, :class => 'error_message') if message.present?
  end

  def spec_label(field, text = nil, options = {})
    label_html = label(field)
    id = extract_element_attribute(label_html, 'for')
    text ||= extract_element_text(label_html)
    @template.spec_label_tag(id, text, options)
  end

  def image_picker(field, options = {})
    image = object.send(field)
    image_url = image.url(*[options[:style]].compact)
    html = ''
    if image.exists?
      destroy_field = "destroy_#{field}"
      html = [@template.image_tag(image_url), check_box(destroy_field), label(destroy_field, "Bild löschen")].join(" ")

    else
      html = file_field field
    end
    @template.content_tag :span, html.html_safe, :class => 'image_picker'
  end

  def user_picker(field, choices, options = {})
    collection_select(field, choices, :id, :email, { :include_blank => true }, :class => 'user_picker')
  end

  def date_picker(field, options = {})
    append_class_option(options, "date_picker")
    value = object.send(field)
    if value.is_a?(Date)
      value = I18n.l(value, :format => :default)
    end
    options[:value] = value
    text_field(field, options)
  end

  def datetime_picker(field, options = {})
    append_class_option(options, "datetime_picker")
    value = object.send(field)
    if value.is_a?(Time)
      value = I18n.l(value, :format => :default)
    end
    options[:value] = value
    text_field(field, options)
  end

  def money_field(field, options = {})
    append_class_option(options, "money_field")
    number_field(field, options.reverse_merge(:unit => "€", :money => true))
  end

  def number_field(field, options = {})
    append_class_option(options, "number_field")
    observe_with = options.delete(:observe_with)
    unit = options.delete(:unit)
    value = object.send(field)
    unless value.blank? || value.is_a?(String)
      value = value.with_comma(options[:money] ? 2 : nil)
    end
    options[:value] = value
    text_field_html = text_field(field, options) + (unit.present? ? " #{unit}" : "")
    text_field_id = extract_element_id(text_field_html)
    html = ''
    html << text_field_html
    html << @template.observe_field(text_field_id, :frequency => 0.2, :function => observe_with) if observe_with
    html.html_safe
  end

  def combo_box(field, choices, options = {})
    if RAILS_ENV == 'test' || RAILS_ENV == 'cucumber'
      text_field(field, options)
    else
      current_choice = object.send(field)
      choices << current_choice unless current_choice.blank? || choices.include?(current_choice)
      more_choice = "Neu..."
      choices << more_choice
      collection_select field, choices, :to_s, :to_s, { :include_blank => true }, options.merge(:class => "combo_box", 'data-combo_box_new_choice' => more_choice)
    end
  end

  def tag_picker(field, options = {})
    tag_classes = %w(xs s m l xl)
    text_field_html = text_field(field, :autocomplete => 'off')
    text_field_id = extract_element_id(text_field_html)
    scope = options[:scope] || object.class #.scoped(:conditions => ["updated_at > ?", Time.now - 18.months])
    cloud = ''
    @template.tag_cloud(scope.tag_counts_on(options[:context] || :tags), tag_classes) do |tag, klass|
      event = "$('##{@template.escape_javascript text_field_id}').tagPicker('add', '#{@template.escape_javascript tag.name}')"
      cloud << @template.link_to_function(ERB::Util.html_escape(tag.name), event, :class => "tag #{klass}")
      cloud << " "
    end
    html = ''
    html << '<div class="tag_picker">'
    html <<   text_field_html
    html <<   '<div class="tag_cloud">'
    html <<     cloud
    html <<   '</div>'
    html << '</div>'
    #debugger
    #html << scope.tag_counts.inspect
    #html << ActsAsTaggableOn::Tag.all.inspect
    #html << ActsAsTaggableOn::Tagging.all.inspect
    html.html_safe
  end  

  private

  def extract_element_id(html)
    extract_element_attribute(html, 'id')
  end

  def extract_element_attribute(html, attr)
    /#{attr}=[\"\'](.*?)[\"\']/.match(html)[1]
  end

  def extract_element_text(html)
    /^<(\w+).*?>(.*?)<\/\1.*?>$/.match(html)[2]
  end

  def append_class_option(options, klass)
    options[:class] ||= ''
    options[:class] << " #{klass}"
  end
  
end

ActionView::Helpers::FormTagHelper.class_eval do

  def spec_label_tag(id, text = nil, options = {})
    @@spec_label_counts ||= Hash.new(0)
    count_key = "#{object_id}/#{text}"
    count = @@spec_label_counts[count_key]
    html = label_tag(id, count == 0 ? text : "#{text} (#{count + 1})", options.merge(:class => "hidden"))
    @@spec_label_counts[count_key] += 1
    html
  end

end
