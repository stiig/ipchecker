# frozen_string_literal: true

class PingStatisticService
  def initialize(statuses)
    @data = statuses
    @succeed_data = @data.succeed(true).order(:duration).pluck(:duration)
  end

  def average
    check_blank { sum.to_f / @succeed_data.size }
  end

  def max
    check_blank { @succeed_data.max }
  end

  def min
    check_blank { @succeed_data.min }
  end

  def median
    return 0 if @succeed_data.empty?

    len = @succeed_data.size
    (@succeed_data[(len - 1) / 2] + @succeed_data[len / 2]) / 2.0
  end

  def lose_percent
    return 0 if @data.succeed(false).blank?
    100 - (@succeed_data.size / @data.size.to_f) * 100
  end

  def standard_deviation
    @succeed_data.blank? ? 0 : Math.sqrt(sample_variance)
  end

  private

  def sum
    @succeed_data.reduce(:+)
  end

  def mean
    sum / @succeed_data.size.to_f
  end

  def sample_variance
    m = mean
    sum = @succeed_data.reduce(0) { |accum, i| accum + (i - m)**2 }
    sum / (@succeed_data.size - 1).to_f
  end

  def check_blank(&_block)
    @succeed_data.blank? ? 0 : yield
  end
end
