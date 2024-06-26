class CheckoutsController < ApplicationController

  def create
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: @cart.collect { |item| item.to_builder.attributes! },
      allow_promotion_codes: true,
      mode: 'payment',
      shipping_address_collection: {allowed_countries: ['FR']},
      custom_text: {
        submit: {message: 'We\'ll email you instructions on how to get started.'},
      },
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url
    })
    redirect_to @session.url, allow_other_host: true
  end


  def success
    if params[:session_id].present?
      session[:cart] = []

      @session_with_expand = Stripe::Checkout::Session.retrieve({id: params[:session_id], expand: ["line_items"]})
      @session_with_expand.line_items.data.each do |line_item|
        @clothe = Clothe.find_by(stripe_clothe_id: line_item.price.product)
      end
    else
      redirect_to cancel_url, alert: "Tu n'as pas acheté de produits :("
    end
  end

  def cancel
  end
end

