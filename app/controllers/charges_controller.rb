class ChargesController < ApplicationController

  before_action :authenticate_user!

  def new
  end

  def create
    @amount = 1500

    #creates a stripe customer object, for associating with the charge
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card => params[:stripeToken]
    )

    #where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, #this is not the app user_id
      amount: @amount, #in pennies
      description: "Upgrade to Premium",
      currency: 'usd'
    )

    current_user.premium!

    # stripe will send back CardErrors, with friedly messages when something goes wrong
    # this rescue block catches and displays those errors
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def downgrade
    user = current_user
    current_user.role = 'standard'
    wikis_private = Wiki.where(private: true, user: current_user)

    if user.save
      wikis_private.update_all(private: false)
      flash[:notice] = "You are now a standard member.  All private wikis are now public."
      redirect_to downgrade_to_standard_path
    else
      flash.now[:alert] = "Can't downgrade your account. Try again."
      redirect_to wikis_path
    end
  end
end
