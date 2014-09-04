# Rake task to check test coverage of RSpec and Cucumber.
# Lives in lib/tasks/rcov.rake.
# Running `rake rcov:all` will put results to RAILS_ROOT/coverage.
# origin: RM

begin
  require 'cucumber/rake/task'
  require 'spec/rake/spectask'

  namespace :rcov do

    Cucumber::Rake::Task.new(:cucumber) do |t|
      t.rcov = true
      t.rcov_opts = %w{--rails --exclude osx\/objc,gems\/,spec\/,features\/ --aggregate coverage.data}
      t.rcov_opts << %[-o "coverage"]
    end

    Spec::Rake::SpecTask.new(:rspec) do |t|
      t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
      t.spec_files = FileList['spec/**/*_spec.rb']
      t.rcov = true
      t.rcov_opts = lambda do
        IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
      end
    end

    desc "Run both specs and features to generate aggregated coverage"
    task :all do |t|
      rm "coverage.data" if File.exist?("coverage.data")
      Rake::Task['rcov:rspec'].invoke
      Rake::Task["rcov:cucumber"].invoke
    end

  end
rescue LoadError
  namespace :rcov do
    desc 'Cucumber or RSpec rake tasks unavailable'
    task :all do
      abort 'Cucumber or RSpec rake tasks are unavailable.'
    end
  end
end
