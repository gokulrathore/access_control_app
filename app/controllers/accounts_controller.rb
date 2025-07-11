class AccountsController < ApplicationController
     def signup
      account = Account.new(account_params)

      if account.age < 13 && params[:account][:parent_email].blank?
        return render json: { error: "Parent email is required for users under 13" }, status: :unprocessable_entity
      end

      if account.age.present?
        assign_age_group(account)
        assign_role_and_consent(account)
      end

      if account.save
        # Handle organization membership creation
        if account.organization_id.present?
          organization = Organization.find_by(id: account.organization_id)

          if organization
            # Enforce organization-specific participation rules
            if organization.min_age && account.age < organization.min_age
              return render json: {
                error: "This organization requires members to be at least #{organization.min_age} years old"
              }, status: :forbidden
            end

            # Use organization_role param or default to :member
            role = params[:account][:organization_role]&.to_sym || :member
            unless  %i[member moderator admin].include?(role)
              return render json: { error: "Invalid organization role" }, status: :unprocessable_entity
            end

            # Create the membership record
            OrganizationMembership.create!(
              account: account,
              organization: organization,
              role: role
            )
          else
            return render json: { error: "Organization not found" }, status: :unprocessable_entity
          end
        end

        render json: account, serializer: AccountSerializer, status: :created
      else
        render json: {
          message: "Signup failed",
          errors: account.errors.full_messages
        }, status: :unprocessable_entity
      end
    end


  def login
    user = Account.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_user_data(user_id: user.id)

      render json: {
        message: 'User logged in successfully',
        token: token,
        account: AccountSerializer.new(user).as_json
      }, status: :ok
    else
      render json: { message: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def account_params
    params.require(:account).permit(:email, :password, :full_name, :age, :role, :age_group_id, :organization_id)
  end


  def assign_role_and_consent(account)
    case account.age
    when 0..12
      if params[:account][:parent_email].present? 
        ParentalConsent.create(
          account: account,
          parent_email: params[:account][:parent_email],
          approved: false
        )
        true
      end
    when 13..17
      account.role = 'minor_user'
    else
      account.role ||= 'user'
    end
  end

  def assign_age_group(account)
    age_group = AgeGroup.find_by("min_age <= ? AND max_age >= ?", account.age, account.age)
    account.age_group_id = age_group.id if age_group
  end
end
