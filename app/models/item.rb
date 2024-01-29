class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_charge
  belongs_to :prefecture
  belongs_to :shipping_date
  belongs_to :user

  validates :name, :description, presence: true

  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_charge_id, numericality: { other_than: 1, message: "can't be blank" }
end
