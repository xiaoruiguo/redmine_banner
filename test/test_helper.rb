begin
  require 'simplecov'
  require 'simplecov-rcov'
rescue LoadError => ex
  puts <<-"EOS"
  This test should be called only for redmine banner test.
    Test exit with LoadError --  #{ex.message}
  Please move redmine_banner/Gemfile.local to redmine_issue_templates/Gemfile
  and run bundle install if you want to to run tests.
  EOS
  exit
end

if ENV['JENKINS'] == 'true'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
end

# NOTE: Remove 'rails' because same issue is happened when run test on CI environment.
#    Ref. https://github.com/colszowka/simplecov/issues/82
# SimpleCov.start 'rails'
SimpleCov.start

require File.expand_path(File.dirname(__FILE__) + '/../../../test/test_helper')

# TODO: Workaround: Fixtures_path could not be set temporary, so this has to do it
ActiveRecord::FixtureSet.create_fixtures(File.dirname(__FILE__) + '/fixtures/',
                                         File.basename('banners', '.*'))
