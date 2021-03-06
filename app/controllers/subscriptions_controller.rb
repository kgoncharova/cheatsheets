class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:create, :destroy]

  def index
    unless current_user.subscribed_tags.any?
      redirect_to cheatsheets_url, notice: "You have no subscriptions"
    end

    @subscriptions = current_user.subscribed_tags
  end

  def create
    @subscription = @tag.subscriptions.where(user_id: current_user.id).first_or_create

    flash[:notice] = "You subscribed #{@tag.name}"
    redirect_back(fallback_location: cheatsheets_url)
  end

  def destroy
    @subscription = @tag.subscriptions.where(user_id: current_user.id).first_or_create
    @subscription.destroy

    flash[:notice] = "You unsubscribed #{@tag.name}"
    redirect_back(fallback_location: cheatsheets_url)
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:tag_id])
  end
end
