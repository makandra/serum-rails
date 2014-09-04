module Serum
  module Rails
    class Metrics

      FRACTION_PRIVATE_CONTROLLER_METHODS = 0.2

      class << self

        attr_reader :metrics

        private

        def metric(name, &block)
          @metrics ||= []
          @metrics << name
          define_method name, &block
        end

      end

      def initialize(root)
        @app = App.new(root)
      end

      metric :unescaped_strings do
        @app.count_lines(
          :pattern => /\b(raw|html_safe)\b/,
          :types => [:ruby, :views]
        )
      end

      metric :controller_actions do
        count = @app.count_lines(
          :pattern => /\bdef\b/,
          :types => [:ruby],
          :folders => 'app/controllers'
        )
        count *= (1 - FRACTION_PRIVATE_CONTROLLER_METHODS)
        count.round
      end

      #metric :gem_count do
      #  @app.gems.size
      #end

      metric :uploaders do
        @app.count_lines(
          :pattern => /\b(has_attached_file|mount_uploader|has_attachment|dragonfly_accessor|has_attached)\b/,
          :types => :ruby
        )
      end

      metric :crypto_terms do
        @app.count_lines(
          :pattern => /SHA1|MD5|Digest|Crypt|Token|Secret|Signature/i,
          :types => :ruby
        )
      end

      metric :cookie_accesses do
        @app.count_lines(
          :pattern => /cookies/,
          :types => [:ruby, :javascript]
        )
      end

      metric :file_accesses do
        @app.count_lines(
          :pattern => /\b(File|Pathname|FileUtils|Dir|render|send_file)\b/,
          :types => :ruby
        )
      end

      metric :mailer_invocations do
        @app.count_lines(
          :pattern => /Mailer/,
          :types => :ruby
        )
      end

      metric :redirects do
        @app.count_lines(
          :pattern => /\bredirect_to\b/,
          :types => :ruby
        )
      end

      metric :json_outputs do
        @app.count_lines(
          :pattern => /\b(to_json|JSON\.generate|JSON\.dump)\b/,
          :types => [:ruby, :views],
          :folders => 'app/views'
        )
      end

      metric :yaml_inputs do
        @app.count_lines(
          :pattern => /\bYAML\.load\b/,
          :types => [:ruby, :views]
        )
      end

      metric :lines_of_code do
        @app.lines_of_code
      end

      def to_hash
        hash = {}
        self.class.metrics.sort.each do |metric|
          hash[metric] = send(metric)
        end
        hash
      end

    end
  end
end

