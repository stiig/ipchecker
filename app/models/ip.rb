# frozen_string_literal: true

require 'resolv'

class Ip < ApplicationRecord
  has_many :statuses

  validates :address, presence: true, uniqueness: true
  validates :address, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }

  after_create :ping_callback, if: :active
  after_save :ping_callback, if: %i[active_changed? active]

  def ping
    req = Net::Ping::External.new(address.to_s)
    req.ping
    statuses.create(duration: req.duration, success: req.exception.blank?)
  end

  def statistic(from, to)
    statistic_service = PingStatisticService.new(statuses.period(from, to))
    {
      average: statistic_service.average,
      min: statistic_service.min,
      max: statistic_service.max,
      median_value: statistic_service.median,
      lose_percent: statistic_service.lose_percent,
      standard_deviation: statistic_service.standard_deviation
    }
  end

  private

  def ping_callback
    PingJob.set(wait: 1.minute).perform_later(id)
  end
end

# == Schema Information
#
# Table name: ips
#
#  active     :boolean          default("true"), not null
#  address    :inet             not null
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ips_on_address  (address) UNIQUE
#
