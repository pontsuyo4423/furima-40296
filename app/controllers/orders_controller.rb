class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_own_item_or_sold, only: [:index]
  def index
    @order_payment = OrderPayment.new
  end

  def create
    @order_payment = OrderPayment.new(order_payment_params)
    if @order_payment.valid? 
      pay_item
      @order_payment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_payment_params
    params.require(:order_payment).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def redirect_if_own_item_or_sold
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
  
  def pay_item
    Payjp.api_key = "sk_test_f31cc8fec5fd5deeb787fe9e" 
      Payjp::Charge.create(
        amount: @item.price, 
        card: order_payment_params[:token],    
        currency: 'jpy'                
      )
  end
end
