class OrdersController < ApplicationController
  before_action :login?

  def create
    @course = Course.find(params[:course_id])
    @order = @course.prepare_order(order_params)
    
    
    if @order.save
      gateway = Braintree::Gateway.new(
        environment: :sandbox,
        merchant_id: ENV['braintree_merchant_id'],
        public_key: ENV['braintree_public_key'],
        private_key: ENV['braintree_private_key']
      )
      result = gateway.transaction.sale(
        {amount: @order.amount,
        payment_method_nonce: params[:nonce]}
      )
      if result.success?
        redirect_to courses_path, notice: "Congrats on your purchase!"
      else
        redirect_to courses_path, notice: "transaction failed"
      end
    end 
  end

  private 
  def order_params
    params.require(:order).permit(:recipient, :address).merge(user: current_user)
  end

end
