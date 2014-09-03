module Serum
  module Rails
    class TypeSelection

      EXTENSIONS_BY_TYPE = {
        :ruby       => %w[ rb ],
        :javascript => %w[ js coffee coffeescript ],
        :views      => %w[ erb haml mab ]
      }.freeze

      DEFAULT_TYPES = EXTENSIONS_BY_TYPE.keys.freeze

      def initialize(types = nil)
        @types = types ? Array.wrap(types) : DEFAULT_TYPES
      end

      #def matches_path?(path)
      #  extensions.any? { |extension|
      #    path.ends_with?("\.#{extension}")
      #  }
      #end

      def extensions
        @types.collect { |type|
          EXTENSIONS_BY_TYPE[type] or raise "No such type: #{type}"
        }.flatten
      end

    end
  end
end
