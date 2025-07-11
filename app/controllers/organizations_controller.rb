class OrganizationsController < ApplicationController
  before_action :authentication
  before_action :set_organization, only: [:show, :update, :destroy]
  before_action :authorize_admin!, only: [:create, :update, :destroy]

  def index
    @organizations = Organization.all
    render json: @organizations
  end

  def show
    render json: @organization
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      render json: @organization, status: :created
    else
      render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @organization.destroy
    head :no_content
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Organization not found' }, status: :not_found
  end

  def organization_params
    params.require(:organization).permit(:name, :description,:min_age)
  end

  def authorize_admin!
    unless @current_user&.role == 'admin'
      render json: { error: 'Unauthorized - Admin only' }, status: :unauthorized
    end
  end
end
