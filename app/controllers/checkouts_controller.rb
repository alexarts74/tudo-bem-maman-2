class CheckoutsController < ApplicationController

  def create
    clothe = Clothe.find(params[:clothe_id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
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
      success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: cancel_url
    })
    redirect_to @session.url, allow_other_host: true
  end

  def success
    session_with_expand = Stripe::Checkout::Session.retrieve({id: params[:session_id], expand: ["line_items"]})
    session_with_expand.line_items.data.each do |line_item|
      clothe = Clothe.find_by(stripe_clothe_id: line_item.price.product)
      clothe.update(sales_count: clothe.sales_count + 1)
      line_item.price.id
    end
  end

  def cancel
  end
end
