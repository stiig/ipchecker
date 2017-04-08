# frozen_string_literal: true

json.extract! ip, :id, :active, :created_at, :updated_at
json.address ip.address.to_s
json.url ip_url(ip, format: :json)
