class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order).permit(:postcode, :city, :block, :building, :phone_number).merge(item_id: @item.id)
  end
end
