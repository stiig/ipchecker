# frozen_string_literal: true

RSpec.describe Ip::Status do
  subject { create(:ip_status) }

  it('can be created') { is_expected.to be }
  it('should not success by default') { expect(subject.success).to be false }

  it { is_expected.to belong_to(:ip) }
end
