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

  it { is_expected.to have_many(:statuses) }

  it do
    ip = create(:ip, active: false)
    ip.active = true
    expect { ip.save }.to have_enqueued_job(PingJob)
    ip.active = false
    expect { ip.save }.not_to have_enqueued_job(PingJob)
  end

  it { expect { create(:ip) }.to have_enqueued_job(PingJob) }
  it { expect { create(:ip, active: false) }.not_to have_enqueued_job(PingJob) }

  describe '#ping' do
    it 'add ping info to statuses' do
      subject.address = '127.0.0.1'
      subject.save
      expect { subject.ping }.to change(subject.statuses, :size)
    end
  end

  describe '#statistic' do
    it 'return statistic' do
      create(:ip_status, success: true, ip: subject, duration: 1)
      create(:ip_status, success: true, ip: subject, duration: 2)
      create(:ip_status, success: true, ip: subject, duration: 3)
      create(:ip_status, success: false, ip: subject, duration: nil)

      statistic = subject.statistic(Date.yesterday, Date.tomorrow)

      expect(statistic).to eq(average: 2.0,
                              min: 1.0,
                              max: 3.0,
                              median_value: 2.0,
                              lose_percent: 25.0,
                              standard_deviation: 1.0)
    end
  end
end
