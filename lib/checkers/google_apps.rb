require 'pry'

class GoogleApps
  def initialize(organization, exceptions)
    @api = nil
    @organization = organization
    @exceptions = exceptions.split
  end

  def check_compliance
    []
  end

  def format(subjects)
    subjects.map do |subject|
      {
        service: 'Google Apps',
        email: subject[:email],
        role: subject[:role],
        user: subject[:email]
      }
    end
  end
end
