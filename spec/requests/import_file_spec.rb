require 'rails_helper'

RSpec.describe "ImportFiles", type: :request do
  let(:user) { create(:user) }
  #file = fixture_file_upload('files/users-2021-03-26.csv', 'text/csv')
  describe "GET /import" do
    it 'redirect to the log_in page as a non logged in user' do
      get '/import'
      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!
      expect(response.body).to include("Log in")
    end

    it 'returns a success response as a logged in user' do
      aggregate_failures do
        sign_in user
        get root_path
        expect(response).to be_successful
        get '/import'
        expect(response).to be_successful
        expect(response.body).to include("Import Contacts")
      end
    end
  end

  # describe "POST /import" do
  #   it 'returns a success response as a logged in user' do
  #     aggregate_failures do
  #       sign_in user
  #       post '/import'
  #       expect(response).to redirect_to(root_path)
  #       follow_redirect!
  #       expect(response.body).to include("Log in")
  #       # get root_path
  #       # expect(response).to be_successful
  #       # get '/import'
  #       # expect(response).to be_successful
  #       # expect(response.body).to include("Import Contacts")
  #     end
  #   end
  # end
end
