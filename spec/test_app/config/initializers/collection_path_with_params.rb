# Patch for resource_controller to use collection_path with additional params.
# origin: RM
ResourceController::Helpers::Urls.module_eval do

  protected

  def collection_path_with_params(params = nil)
    collection_path_without_params.tap do |path|
      if params.present?
        path << (path.include?('?') ? '&' : '?')
        path << params.collect{ |key, value| "#{CGI::escape(key.to_s)}=#{CGI::escape(value.to_s)}" }.join('&')
      end
    end
  end

  alias_method_chain :collection_path, :params

end
