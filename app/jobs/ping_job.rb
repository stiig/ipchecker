# frozen_string_literal: true

class PingJob < ApplicationJob
  queue_as :default

  def perform(id)
    ip = Ip.where(active: true).find(id)

    ip.ping
    PingJob.set(wait: 1.minute).perform_later(ip.id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
end
