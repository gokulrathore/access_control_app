class ParentalConsentsController < ApplicationController
  before_action :authentication
  before_action :authorize_admin!

	def approve
	  consent = ParentalConsent.find_by(id: params[:id])
	  
	  if consent
	    consent.update(approved: true)
	    render json: { message: "Parental consent approved" }
	  else
	    render json: { error: "Consent record not found" }, status: :not_found
	  end
	end
 
   private
	def authorize_admin!
	  unless @current_user&.role == "admin"
	    render json: { error: "Only admins can approve parental consent" }, status: :unauthorized
	  end
	end
end
