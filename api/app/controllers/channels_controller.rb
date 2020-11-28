class ChannelsController < ApplicationController
  before_action :set_channel, only: [:show, :update, :destroy]

  # GET /channels
  def index
    channels = current_user.channels
    json_response(channels)
  end

  # GET channels/:id
  def show
    json_response(@channel)
  end

  # POST /channels
  def create
    channel = current_user.channels.create!(channel_params)
    json_response(channel, :created)
  end

  # PUT /channels/:id
  def update
    @channel.update(channel_params)
    head :no_content
  end

  # DELETE /channels/:id
  def destroy
    @channel.destroy
    head :no_content
  end

  private

  def channel_params
    params.permit(:name, :remote_id, :category, :provider_id)
  end

  def set_channel
    @channel = current_user.channels.find_by!(id: params[:id])
  end
end