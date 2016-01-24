require 'dotenv'
require 'pry'

require './lib/checkers/heroku.rb'
require './lib/checkers/github.rb'
require './lib/checkers/google_apps.rb'

class TwoFaComplianceChecker

  def initialize
    Dotenv.load
  end

  def process
    notify(check)
  end

  def check
    services = [
      Heroku.new(ENV['HEROKU_ORG'], ENV['HEROKU_EXCEPTIONS']),
      GitHub.new(ENV['GITHUB_ORG'], ENV['GITHUB_EXCEPTIONS'])
      #GoogleApps.new(nil, ENV['GOOGLEAPPS_EXCEPTIONS'])
    ].collect { |service| service.check_compliance }.flatten
  end

  def notify(subjects)
    subjects.each do |subject|
      puts "#{subject[:service]}: #{subject[:name] ? subject[:name] : subject[:user]} (#{subject[:email]})"
    end
  end
end
