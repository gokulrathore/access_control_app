module OrganizationAuthorization
  extend ActiveSupport::Concern

  def authorize_organization_role!(required_roles = [])
    organization_id = params[:organization_id] || params[:id]

    membership = OrganizationMembership.find_by(
      account_id: @current_user.id,
      organization_id: organization_id
    )

    unless membership && required_roles.map(&:to_s).include?(membership.role)
      render json: { error: "Access denied. Requires role: #{required_roles.join(', ')}" }, status: :unauthorized
    end
  end
end
