# frozen_string_literal: true

describe PingJob do
  let!(:ip_active) { create(:ip) }
  let!(:ip_inactive) { create(:ip, active: false) }

  describe '#perform' do
    it 'insert ip in queue if ip active' do
      expect { described_class.perform_now(ip_active.id) }.to have_enqueued_job(described_class)
      expect { described_class.perform_now(ip_active.id) }.to change(ip_active.statuses, :count)
    end
    it 'does not insert ip in queue if ip not active' do
      expect { described_class.perform_now(ip_inactive.id) }.not_to have_enqueued_job(described_class)
      expect { described_class.perform_now(ip_inactive.id) }.not_to change(ip_inactive.statuses, :count)
      ip_active.active = false
      ip_active.save
      expect { described_class.perform_now(ip_active.id) }.not_to have_enqueued_job(described_class)
      expect { described_class.perform_now(ip_active.id) }.not_to change(ip_active.statuses, :count)
    end
  end
end
