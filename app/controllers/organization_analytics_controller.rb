# app/controllers/organization_analytics_controller.rb
class OrganizationAnalyticsController < ApplicationController
  before_action :authentication
  before_action :set_organization
  before_action :authorize_analytics_access!

  def index
    memberships = @organization.organization_memberships.includes(:account)

    analytics = {
      total_members: memberships.count,
      roles_breakdown: memberships.group(:role).count,
      age_group_distribution: age_group_distribution(memberships),
      recent_signups: recent_signups_by_day(memberships)
    }

    render json: analytics
  end

  private

  def set_organization
    @organization = Organization.find_by(id: params[:organization_id])
    unless @organization
      render json: { error: "Organization not found" }, status: :not_found
    end
  end

  def authorize_analytics_access!
    membership = OrganizationMembership.find_by(
      account_id: @current_user.id,
      organization_id: @organization.id
    )
    unless @current_user.role == 'admin' || membership.role == 'moderator' || membership.role == 'admin'
      render json: { error: "Access denied: Insufficient permissions" }, status: :forbidden
    end
  end

  def age_group_distribution(memberships)
    memberships.map { |m| m.account&.age_group_id }.compact.tally
  end

  def recent_signups_by_day(memberships)
    memberships.group_by { |m| m.created_at.to_date }.transform_values(&:count)
  end
end
