# frozen_string_literal: true

class IpsController < ApplicationController
  before_action :set_ip, only: %i[show update destroy]

  def index
    @ips = Ip.all
  end

  def show; end

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
end
