# Methods added to this helper will be available to all templates in the application.
# origin: RM
module ApplicationHelper

  def icon(icon, label)
    content_tag(:span, label, :class => "#{icon}_icon")
  end
  
  def page_head(options = {})
    html = ''.html_safe
    html << content_tag(:h1, options[:title]) if options[:title]
    html << render_navigation(options[:navigation]) if options[:navigation]
    if html.present?
      content_for(:page_head) do
        content_tag(:div, :id => 'page_head') do
          content_tag(:div, :id => 'page_head_inner') do
            html
          end
        end
      end
    end
  end

  def page_navigation(navigation)
    content_for(:page_navigation, render_navigation(navigation, :id => 'page_navigation'))
  end

  def uid
    @@next_uid ||= 0
    @@next_uid += 1
    "element_uid_#{@@next_uid}"
  end

  # This method is supposed to work with Tex output. Don't use HTML entities.
  def money_amount(amount)
    if amount.present?
      "#{amount.with_comma(2)} €" # this includes a nbsp!
    else
      "–" # &dash;
    end
  end  

  def maybe_blank(value, options = {})
    if value.present?
      if options[:url] && Patterns::URL.match(value)
        link_to(value, value)
      elsif options[:simple_format]
        simple_format(value)
      else
        value
      end
    else
      '&ndash;'.html_safe
    end
  end

  def body_id(id)
    content_for :body_id, id    
  end

  def help(message)
    content_tag :span, "(#{h message})".html_safe, :class => 'help'
  end

  def clear
    content_tag :div, '', :class => 'clear'
  end

  def todo(message)
    content_tag :span, h(message), :class => 'todo'
  end

  def pagination(collection)
    will_paginate collection, :previous_label => "&laquo; zurück", :next_label => "weiter &raquo;"
  end

  def buttons(options = {}, &block)
    content = capture(&block)
    if content.present?
      content += content_tag(:div, options[:links], :class => 'links') if options[:links]
      html = content_tag :div, content.html_safe, :class => "buttons #{options[:class]}"
      block_called_from_erb?(block) ? concat(html) : html
    end
  end

  def save_cancel_buttons(options = {})
    cancel_path = options.delete(:cancel_path) || root_path
    save_label = options.delete(:save_label) || "Save"
    cancel_label = options.delete(:cancel_label) || "Cancel"
    buttons(options.reverse_merge(:class => 'bar')) do
      html = ''
      html << submit_tag(save_label, :class => "submit", :disable_with => "Please wait...")
      html << button_to_function(cancel_label, "location.href = '#{cancel_path}'")
      html
    end
  end

  def boring_create_button(options = {}, &block)
    button = link_to(icon(:create, options[:label] || "Add"), new_object_path)
    buttons(&prepend_html_to_block(button, block))
  end
  
  def boring_delete_button(options = {}, &block)
    link_to(icon(:delete, "Delete"), object_url, :method => :delete)
  end
  
  def boring_edit_button(options = {}, &block)
    link_to(icon(:edit, "Edit"), edit_object_url)
  end

  def prepend_html_to_block(html, block)
    lambda do
      concatenated = ''.html_safe
      concatenated << html
      concatenated << capture(&block) if block
      concatenated
    end
  end

  def boring_save_cancel_buttons(options = {})
    target = translate_model_name(object)
    deleted = object.respond_to?(:deleted?) && object.deleted?
    links = options.delete(:links)
    cancel_path = options.delete(:cancel_path) || collection_path
    action = deleted ? "restore" : "delete"
    delete_link = if options[:delete_link] && !object.new_record?
      link_class = deleted ? "restore" : "delete"
      label = icon(link_class, action.titleize)
      confirm = options[:"confirm_#{link_class}"] || "#{action.titleize} this #{target}?"
      confirm = confirm.call if confirm.respond_to?(:call)
      link_to(label, object_url(object), :method => :delete, :confirm => confirm)
    else
      nil
    end
    save_cancel_buttons options.merge(
      :links => "#{links} #{delete_link}".html_safe,
      :cancel_path => cancel_path
    )
  end

  def list
    content_tag(:div, render('list'), :id => 'list')
  end

  def columns(&content)
    concat(
      content_tag(:div, capture(&content) + clear, :class => 'columns')
    )
  end

  def column(options = {}, &content)
    size_class = [options[:size], 'column'].compact.join('_')
    klass = [size_class, options[:class]].join(' ')
    content = capture(&content)
    content = segment(:title => options[:segment], :content => content) if options[:segment]
    html = content_tag(:div, :class => klass) do
      content_tag(:div, content, :class => 'column_inner')
    end
    concat html
  end

  def segment(options = {}, &block)
    title = options[:title]
    html = ''
    html << "<div class='segment #{options[:class]}' id='#{options[:id]}' data-show-for='#{options[:"data-show-for"]}'>"
    html << "<h3 class=\"segment_title\"><span>#{title}</span></h3>" if title.present?
    html << '<div class="segment_body">'
    html << (options[:content] || capture(&block))
    html << '</div>'
    html << "</div>"
    html = html.html_safe
    block && block_called_from_erb?(block) ? concat(html) : html
  end

  def graceful_link_to_remote(name, options = {}, html_options = nil)
    html_options ||= {}
    link_to_remote(name, options, html_options.merge(:href => options[:url], :method => options[:method]))
  end

end
