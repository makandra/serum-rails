module Serum
  module Rails
    class CodeScanner

      DEFAULT_FOLDERS = %w[app lib config public].freeze
      ANYTHING = /.*/.freeze

      def initialize(root)
        @root = root
      end

      def count_lines(options = {})
        pattern = options.fetch(:pattern, ANYTHING)
        folders = options.fetch(:folders, DEFAULT_FOLDERS)
        type_selection = TypeSelection.new(options[:types])
        paths(folders, type_selection).sum do |path|
          puts path
          count_occurrences(path, pattern)
        end
      end

      private

      def paths(folders, type_selection)
        patterns = []
        folders.each do |folder|
          type_selection.extensions.each do |extension|
            patterns << "#{@root}/#{folder}/**/*.#{extension}"
          end
        end
        puts "Calling patterns: #{patterns}"
        Dir[*patterns]
      end

      def count_occurrences(path, pattern)
        content = File.read(path) or raise "Could not read file: #{path}"
        content.scan(pattern).tap { |m| p m }.size
      end

    end
  end
end