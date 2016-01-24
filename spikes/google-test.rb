require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

# Initialize the client.
client = Google::APIClient.new(
  :application_name => 'Example Ruby application',
  :application_version => '1.0.0'
)

# Initialize Google+ API. Note this will make a request to the
# discovery service every time, so be sure to use serialization
# in your production code. Check the samples for more details.
plus = client.discovered_api('plus')

# Load client secrets from your client_secrets.json.
client_secrets = Google::APIClient::ClientSecrets.load

# Run installed application flow. Check the samples for a more
# complete example that saves the credentials between runs.
flow = Google::APIClient::InstalledAppFlow.new(
  :client_id => client_secrets.client_id,
  :client_secret => client_secrets.client_secret,
  :scope => ['https://www.googleapis.com/auth/plus.me']
)
client.authorization = flow.authorize

# Make an API call.
result = client.execute(
  :api_method => plus.activities.list,
  :parameters => {'collection' => 'public', 'userId' => 'me'}
)

puts result.data
