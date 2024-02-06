require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    @order_payment = FactoryBot.build(:order_payment)
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it '全ての項目が正しく入力されていれば、購入できる。' do
        expect(@order_payment).to be_valid
      end
      it '建物名がなくても購入できる。' do
        @order_payment.building = ''
        expect(@order_payment).to be_valid
      end
    end
    context '商品購入できない時' do
      it 'user_idが空だと登録できない' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと登録できない' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end
      it 'トークンがないと購入できない。' do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号がないと購入できない。' do
        @order_payment.postcode = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号にハイフンがないと登録できない。' do
        @order_payment.postcode = '1111111'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が—-だと登録できない。' do
        @order_payment.prefecture_id = 1
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村がないと登録できない。' do
        @order_payment.city = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと登録できない' do
        @order_payment.block = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号がないと登録できない。' do
        @order_payment.phone_number = ''
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると登録できない。' do
        @order_payment.phone_number = '000-0000-0000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が１２桁以上だと登録できない。' do
        @order_payment.phone_number = '000000000000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下だと登録できない。' do
        @order_payment.phone_number = '000000000'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が全角だと登録できない。' do
        @order_payment.phone_number = '０００００００００'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
