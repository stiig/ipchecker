# frozen_string_literal: true

describe IpsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/ips').to route_to('ips#index', format: 'json')
    end

    it 'routes to #show' do
      expect(get: '/ips/1').to route_to('ips#show', id: '1', format: 'json')
    end

    it 'routes to #create' do
      expect(post: '/ips').to route_to('ips#create', format: 'json')
    end

    it 'routes to #update via PUT' do
      expect(put: '/ips/1').to route_to('ips#update', id: '1', format: 'json')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/ips/1').to route_to('ips#update', id: '1', format: 'json')
    end

    it 'routes to #destroy' do
      expect(delete: '/ips/1').to route_to('ips#destroy', id: '1', format: 'json')
    end
  end
end
