module Serum
  module Rails
    class CodeScanner

      DEFAULT_FOLDERS = %w[app lib config public].freeze
      ANYTHING = /.*/.freeze
      DEBUG = false

      def initialize(root)
        @root = root
      end

      def count_lines(options = {})
        pattern = options.fetch(:pattern, ANYTHING)
        folders = Array.wrap(options.fetch(:folders, DEFAULT_FOLDERS))
        type_selection = TypeSelection.new(options[:types])
        paths(folders, type_selection).sort.sum do |path|
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
        # puts "Calling patterns: #{patterns}"
        Dir[*patterns]
      end

      def count_occurrences(path, pattern)
        content = File.read(path) or raise "Could not read file: #{path}"
        #if path =~ /session_store/
        #  puts "-----"
        #  puts content
        #  puts "-----"
        #end
        matches = content.scan(pattern)
        matches.each { |match| puts "#{path}: #{match}" } if DEBUG
        matches.size
      end

    end
  end
end