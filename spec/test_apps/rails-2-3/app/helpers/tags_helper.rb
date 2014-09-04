# Helper for displaying tag clouds (not used in CaP).
# origin: RM
module TagsHelper

  def render_tags(tags)
    tags = tags.collect do |tag|
      tag.respond_to?(:name) ? tag.name : tag
    end
    content_tag :div, :class => 'tags' do
      tags.sort_by { |t| t.downcase }.collect do |tag|
        content_tag :span, h(tag), :class => 'tag'
      end.join(' ').html_safe
    end
  end

end
