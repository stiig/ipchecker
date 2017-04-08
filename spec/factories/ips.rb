# frozen_string_literal: true

FactoryGirl.define do
  factory :ip do
    address { Faker::Internet.ip_v4_address }
  end
end
