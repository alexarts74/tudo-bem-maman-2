class CheckoutsController < ApplicationController

  def create
    clothe = Clothe.find(params[:clothe_id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          unit_amount: clothe.price * 100, # Convert price to cents
          product_data: {
            name: clothe.name,
          },
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: root_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: root_url
    })
    redirect_to @session.url, allow_other_host: true
  end
end
