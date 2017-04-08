# frozen_string_literal: true

describe Ip do
  subject { create(:ip) }

  it('can be created') { is_expected.to be }
  it('should active by default') { expect(subject.active).to be true }

  it { is_expected.to validate_presence_of(:address) }

  it { is_expected.to allow_value(Faker::Internet.ip_v4_address).for(:address) }
  it { is_expected.to allow_value(Faker::Internet.ip_v6_address).for(:address) }
  it { is_expected.not_to allow_value('127.0.0.256').for(:address) }

  it { is_expected.to validate_uniqueness_of(:address) }
  it { is_expected.to have_db_index(:address).unique(true) }
end
