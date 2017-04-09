# frozen_string_literal: true

class IpsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_ip, only: %i[show update destroy]

  def index
    @ips = Ip.all
  end

  def show
    @statistic = @ip.statistic(params_for_date[:from], params_for_date[:to]) if params_for_date
  end

  def create
    @ip = Ip.new(ip_params)
    if @ip.save
      render :show, status: :created, location: @ip
    else
      render json: @ip.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ip.update(ip_params)
      render :show, status: :ok, location: @ip
    else
      render json: @ip.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ip.destroy
    head :no_content
  end

  private

  def set_ip
    @ip = Ip.find(params[:id])
  end

  def ip_params
    params.require(:ip).permit(:address, :active)
  end

  def params_for_date
    return unless params[:from].present? && params[:to].present?
    { from: Time.zone.parse(params[:from]), to: Time.zone.parse(params[:to]) }
  rescue
    nil
  end
end
