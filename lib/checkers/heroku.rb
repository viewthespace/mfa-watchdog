require 'platform-api'

class Heroku
  def initialize(organization, exceptions)
    @api = PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH_TOKEN'])
    @organization = organization
    @exceptions = exceptions.split(',')
  end

  def check_compliance
    org_users = @api.organization_member.list(@organization)
    # {"created_at"=>"2014-11-14T18:31:17Z", "email"=>"shawn.omara@viewthespace.com", "role"=>"admin", "two_factor_authentication"=>true, "updated_at"=>"2014-11-14T18:31:17Z"}
    naughty_users = org_users.select { |member| member['two_factor_authentication'] == false }
    naughty_users.delete_if { |user| @exceptions.include?(user[:email]) } #filter known exceptions
    format(naughty_users)
  end

  def format(subjects)
    subjects.map do |subject|
      {
        service: 'Heroku',
        email: subject['email'],
        role: subject['role'],
        user: subject['email']
      }
    end
  end
end
