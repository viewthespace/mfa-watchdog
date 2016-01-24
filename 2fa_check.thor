require './lib/2fa_compliance_checker.rb'

class SecurityCheck < Thor

  desc "two_fa", "checks services to detect users that don't have 2fa enabled"
  def two_fa
    TwoFaComplianceChecker.new.process
  end
end
