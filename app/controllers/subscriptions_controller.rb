class SubscriptionsController < ApplicationController

  def index
  end

  def new
  	# plan = plan.find(params[:plan_id])
  	# @subscription = plan.subscription.build
  	@subscription = Subscription.new
  end

  def create
    card = params[:subscription][:card_number]
    verify = params[:subscription][:card_verification]

  @subscription = Subscription.new(params[:subscription])
  if @subscription.save_with_payment(card, verify)
    current_user.update_attributes(:purchased_at => Time.now)
    redirect_to episodes_path, :notice => "Thank you for subscribing!"
  else
    raise @subscription.errors.inspect
    render :new
  end
end

  
end
