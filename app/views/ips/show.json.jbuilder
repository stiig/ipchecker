# frozen_string_literal: true

json.partial! 'ips/ip', ip: @ip, statistic: @statistic
json.statistic @statistic
