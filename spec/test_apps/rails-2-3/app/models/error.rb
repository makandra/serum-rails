# Utility class to extract validation errors from ActiveRecord models in a readable fashion.
# origin: RM
class Error

  def self.messages(object, options = {})
    except = Set.new(options.delete(:except) || [])
    object.errors.collect do |attribute, _|
      message(object, attribute) unless except.include? attribute
    end.compact
  end

  def self.message(object, attribute)
    message = Array(object.errors.on(attribute))
    if message.present?
      message = message.first
      if message.starts_with?('^')
        message[1..-1]
      else
        translated_attribute = I18n.t("activerecord.attributes.#{object.class.name.underscore}.#{attribute}")
        "#{translated_attribute} #{message}"  
      end
    end
  end

end
