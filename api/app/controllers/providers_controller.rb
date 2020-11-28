class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :update, :destroy]

  # GET /providers
  def index
    @providers = Provider.all
    json_response(@providers)
  end

  # POST /providers
  def create
    @provider = Provider.create!(provider_params)
    json_response(@provider, :created)
  end

  # GET /providers/:id
  def show
    json_response(@provider)
  end

  # PUT /providers/:id
  def update
    @provider.update(provider_params)
    head :no_content
  end

  # DELETE /providers/:id
  def destroy
    @provider.destroy
    head :no_content
  end

  private

  def provider_params
    # whitelist params
    params.permit(:name)
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end
end