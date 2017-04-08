# frozen_string_literal: true

json.array! @ips, partial: 'ips/ip', as: :ip
