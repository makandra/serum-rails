module Serum
  module Rails
    class App

      attr_reader :root

      def initialize(root)
        @root = File.expand_path(root)
        ensure_root_exists
        ensure_is_rails_app
      end

      #def gems
      #  cd
      #  bundle list | wc -l
      #end

      def lines_of_code
        count_lines # matches anything in all folders
      end

      delegate :count_lines, :to => :code_scanner

      def count_routes
        Dir.chdir(@root) do
          run_command('bundle exec rake routes').split(/\n/).size - 1
        end
      end

      def count_gems
        Dir.chdir(@root) do
          run_command('bundle list').split(/\n/).size - 1
        end
      end

      private

      def run_command(cmd)
        Bundler.with_clean_env do
          result = `#{cmd}`
          $?.success? or raise "Error while running command: #{cmd}"
          result
        end
      end

      def ensure_root_exists
        File.directory?(@root) or raise "Not a directory: #{@root}"
      end

      def ensure_is_rails_app
        expected_folders = %w[
          app/models
          app/controllers
          app/views
          config
          db
        ]
        expected_folders.each do |expected_folder|
          path = File.join(@root, expected_folder)
          File.directory?(path) or raise "Not a Rails application: #{@root} (expected folder #{expected_folder}"
        end
      end

      def code_scanner
        @code_scanner ||= CodeScanner.new(@root)
      end

    end
  end
end
