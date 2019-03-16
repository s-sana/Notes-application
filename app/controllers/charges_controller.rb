
class ChargesController < ApplicationController
  def new

  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    if charge.paid
      # flash[:notice] = "Payment successful"
      current_user.update(stripe_charge_id: charge.id)
      redirect_to notes_path, notice: "Payment successful"
    #else
      #  flash[:warning] = "Payment proccess failed. Try Again.!"
    end


    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

#   def refund
#     id = User.find(params[:id])
#     render plain:[id].inspect
#     #refunded = Stripe::Refund.create({ charge: refund.user_chargeid,})
#     # charge = Stripe::Charge.retrieve(charge: refund.user_chargeid)
#     # refunded = charge.refund
#     # refunded = Stripe::Refund.create({ charge: refund.strip_charge_id,})
#     refund = Stripe::Refund.create({
#     charge: find(:stripe_charge_id),
# })
#
#     if refunded.status == succeeded
#       current_user.update(refunded: true)
#       redirect_to notes_path, notice: "Refund successful"
#     end
#   end
end
