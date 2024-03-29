class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, Rails.application.credentials[:webhook_stripe])
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end
    puts event.inspect

    if event.type == 'checkout.session.completed'
      session = event.data.object
      session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"]})
      session_with_expand.line_items.data.each do |line_item|
        clothe = Clothe.find_by(stripe_clothe_id: line_item.price.product)
        clothe.increment!(:sales_count)
      end
    end
    render json: { message: 'success' }
  end
end
