require 'slack-notifier'

class SlackNotifier

  def initialize
    @slack_user = ENV['SLACK_USER']
    @slack_channel = ENV['SLACK_CHANNEL']
    @slack_webhook = ENV['SLACK_WEBHOOK']
  end

  def notify(subjects)
    if (subjects.size > 0)
      notifier = Slack::Notifier.new(@slack_webhook, channel: @slack_channel, username: @slack_user)
      notifier.ping("users without 2FA enabled: ")
      notifier.ping(format_message(subjects))
    end
  end

  private

  def format_message(subjects)
    subjects.map { |subject| "#{subject[:service]}: #{subject[:name] ? subject[:name] : subject[:user]} (#{subject[:email]})" }.join("\n")
  end
end

class CliNotifier
  def notify(subjects)
    subjects.each do |subject|
      puts "#{subject[:service]}: #{subject[:name] ? subject[:name] : subject[:user]} (#{subject[:email]})"
    end
  end
end
