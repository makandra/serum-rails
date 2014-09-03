# Provides an index action with includes, an order, find-as-you-type search, pagination and an option to see deletable records.
# origin: RM
module BoringControllerTrait::IndexTrait
  as_trait do |options|

    afterlife = options.delete(:afterlife) || :deleted
    show_afterlife = "show_#{afterlife}"
    with_afterlife = "with_#{afterlife}"
    
    index.wants.html do
      render :partial => "list" if request.xhr?
    end

    private

    define_method :collection do
      list = collection_scope
      list = list.scoped(:include => options[:include]) if options[:include]
      list = list.scoped(:order => options[:order]) if options[:order]
      list = list.send(with_afterlife, params[show_afterlife] == '1') if list.respond_to?(with_afterlife)
      list = list.search(*search_args) if list.respond_to?(:search) && params[:query].present?
      list = paginate(list)
      list
    end

    define_method :collection_scope do
      end_of_association_chain
    end

    define_method :paginate do |scope|
      scope.paginate(:page => params[:page], :per_page => PAGE_SIZE)
    end

    define_method :search_args do
      params[:query]      
    end

  end
end
