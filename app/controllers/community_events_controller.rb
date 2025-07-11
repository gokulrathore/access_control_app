class CommunityEventsController < ApplicationController
  before_action :authentication
  before_action -> { restrict_to_age_groups!(["Child", "Teen", "Adult"]) }, only: [:index, :show]
  before_action :authorize_platform_admin!, only: [:create]

  def index
    events = CommunityEvent.all
    personalized = personalize_events_for(@current_user, events)
    render json: personalized
  end

  def show
    event = CommunityEvent.find_by(id: params[:id])
    if event
      render json: event
    else
      render json: { error: "Event not found" }, status: :not_found
    end
  end

  def create
    event = CommunityEvent.new(event_params)

    if event.save
      render json: event, status: :created
    else
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def personalize_events_for(user, events)
    case user.age_group&.name
    when "Child"
      events.where(audience: ["Child", "All"])
    when "Teen"
      events.where(audience: ["Teen", "All"])
    when "Adult"
      events.where(audience: ["Adult", "All"])
    else
      events.none
    end
  end

  def event_params
    params.require(:community_event).permit(:title, :description, :starts_at, :audience)
  end

  def authorize_platform_admin!
    unless @current_user&.role == "admin"
      render json: { error: "Only platform admins can create events" }, status: :unauthorized
    end
  end
end
