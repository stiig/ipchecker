# frozen_string_literal: true

class Ip::Status < ApplicationRecord
  belongs_to :ip

  scope(:succeed, ->(state) { where(success: state) })
  scope(:period, ->(from, to) { where(created_at: from..to) })
end

# == Schema Information
#
# Table name: ip_statuses
#
#  created_at :datetime         not null
#  duration   :float
#  id         :integer          not null, primary key
#  ip_id      :integer          not null
#  success    :boolean          default("false"), not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ip_statuses_on_ip_id  (ip_id)
#
