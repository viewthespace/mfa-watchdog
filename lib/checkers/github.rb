require 'octokit'

class GitHub
  def initialize(organization, exceptions)
    @api = Octokit::Client.new(access_token: ENV['GITHUB_OAUTH_TOKEN'])
    user = @api.user
    user.login
    @organization = organization
    @exceptions = exceptions.split(',')
  end

  def check_compliance
    #puts "fetching GitHub users for #{@organization}"
    naughty_members = @api.organization_members(@organization, filter: '2fa_disabled')
    naughty_users = naughty_members.map { |member| @api.user(member[:login]) }
    naughty_users.delete_if { |user| @exceptions.include?(user[:login]) } #filter known exceptions
    format(naughty_users)
  end

  def format(subjects)
    subjects.map do |subject|
      {
        service: 'GitHub',
        email: subject[:email],
        name: subject[:name],
        user: subject[:login]
      }
    end
  end
end
