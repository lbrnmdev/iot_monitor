class DevicesController < ApplicationController
  before_action :set_device, only: [:show]
  before_action :current_time_zone, only: [:show]

  def show
  end

  private

    def set_device
      @device = Device.find(params[:id])
    end

    def current_time_zone
      @zone = Time.now.zone
    end
end
