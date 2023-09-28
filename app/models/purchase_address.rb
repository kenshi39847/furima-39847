class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street, :building, :telephone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :municipalities
    validates :street
    validates :telephone_number, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street: street, buildinge: building, telephone_number: telephone_number)
  end
end