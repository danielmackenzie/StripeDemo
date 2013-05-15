class TransactionController < ApplicationController
  def handleStripeTransaction
    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://manage.stripe.com/account
    Stripe.api_key = "sk_test_cLjpG1Lkm79nLZL9t8OB2vi4"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
        :card => token,
        :description => "Test User: " +  params[:name]
    )

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
          :amount => params[:amount], # amount in cents, again
          :currency => "cad",
          :customer => customer.id,
          :description => "Demo App Charge"
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
  end
end
