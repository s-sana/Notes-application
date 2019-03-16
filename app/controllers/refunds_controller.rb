class RefundsController < ApplicationController
  def new
    refund = Refund.new
  end
  def create
    @refund = current_user.refunds.new(refund_params)
    if @refund.save
      flash[:notice] = "Refund Request Sent."
    else
      flash[:danger] = "Failed to send refund request."
    end
    redirect_to notes_path
  end

  private

  def refund_params
    params.require(:refund).permit(:reason)
  end
end
