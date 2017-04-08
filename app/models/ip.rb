# frozen_string_literal: true

require 'resolv'

class Ip < ApplicationRecord
  validates :address, presence: true, uniqueness: true
  validates :address, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }
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
