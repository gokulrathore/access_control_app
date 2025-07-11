module AgeGroupAuthorization
  extend ActiveSupport::Concern

  def restrict_to_age_groups!(allowed_group_names = [])
    age_group = AgeGroup.find_by(id: @current_user.age_group_id)

    unless age_group && allowed_group_names.include?(age_group.name)
      render json: { error: "Access restricted for your age group" }, status: :forbidden
    end
  end
end
