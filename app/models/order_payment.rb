class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :prefecture_id, :postcode, :city, :block, :building, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A\d{10,11}\z/}
  end

  def save
    order = Order.create(user_id: user, item_id: item)
    Payment.create(prefecture_id: prefecture_id, postcode: postcode, city: city, block: block, building: building, phone_number: phone_number)
  end
end