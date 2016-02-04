require './lib/mfa_watchdog.rb'

class MfaWatchdog < Thor

  desc "check", "checks services to detect users that don't have 2fa enabled and notifies slack"
  def check
    MfaWatchdogChecker.new.process
  end

end
