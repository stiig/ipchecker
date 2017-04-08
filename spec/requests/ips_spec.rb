# frozen_string_literal: true

RSpec.describe 'Ips' do
  let(:ip) { create(:ip) }
  let(:valid_attributes) { attributes_for(:ip) }
  let(:invalid_attributes) { { invalid: :data } }

  describe 'GET #index' do
    it 'assigns all ips as @ips' do
      create_list(:ip, 10)
      get ips_path
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.size).to eq 10
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ip as @ip' do
      get ip_path(ip)
      expect(response).to have_http_status(200)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body['id']).to eq ip.id
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Ip' do
        expect do
          post ips_path, params: { ip: valid_attributes }
        end.to change(Ip, :count).by(1)
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['address']).to eq valid_attributes[:address]
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post ips_path, params: { ip: invalid_attributes }
        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_body['address'].size).not_to be 0
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { attributes_for(:ip) }

      it 'updates the requested ip' do
        put ip_path(ip), params: { ip: new_attributes }
        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(parsed_body['address']).to eq new_attributes[:address]
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        put ip_path(ip), params: { ip: { address: '127.0.0.256' } }
        parsed_body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_body['address'].size).not_to be 0
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ip' do
      ip = create(:ip)
      expect do
        delete ip_path(ip)
      end.to change(Ip, :count).by(-1)
    end
  end
end
