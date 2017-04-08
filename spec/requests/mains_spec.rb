# frozen_string_literal: true

describe 'Main page' do
  describe 'GET /' do
    it 'open index page' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).to eq 'nothing to show'
    end
  end
end
