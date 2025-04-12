require_relative '../../app/services/near_api_service'

# Configure the NearApiService with the API key and initialize the NearApiService.
api_key = Rails.application.credentials.api_key
NearApiService.setup(api_key)