require 'dotenv'
require 'pry'

require './lib/checkers/heroku.rb'
require './lib/checkers/github.rb'
require './lib/checkers/google_apps.rb'
require './lib/notifiers.rb'

class MfaWatchdogChecker

  def initialize
    Dotenv.load
    @notifiers = [
      CliNotifier.new,
      SlackNotifier.new
    ]
  end

  def process
    naughty_list = check()
    @notifiers.each { |it| it.notify(naughty_list) }
  end

  def check
    [
      Heroku.new(ENV['HEROKU_ORG'], ENV['HEROKU_EXCEPTIONS']),
      GitHub.new(ENV['GITHUB_ORG'], ENV['GITHUB_EXCEPTIONS'])
      #GoogleApps.new(nil, ENV['GOOGLEAPPS_EXCEPTIONS'])
    ].collect { |service| service.check_compliance }.flatten
  end
end
