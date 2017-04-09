# frozen_string_literal: true

FactoryGirl.define do
  factory :ip_status, class: 'Ip::Status' do
    duration { Faker::Number.between(0.0, 3) }
    ip
  end
end
