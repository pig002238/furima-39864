require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  describe '商品購入記録の保存' do
    before do
       @purchase_form = FactoryBot.build(:purchase_form)
    end

    context '問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@purchase_form).to be_valid
      end
      it ' 建物名は任意であること' do
        @purchase_form.building = nil
        expect(@purchase_form).to be_valid
      end
    end

    context '問題がある場合' do
      it '郵便番号が必須であること' do
        @purchase_form.postal_code = ""
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @purchase_form.postal_code = '1231234'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県が必須であること' do
        @purchase_form.prefecture_id = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が必須であること' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地が必須であること' do
        @purchase_form.street_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Street number can't be blank")
      end
      it '電話番号が必須であること' do
        @purchase_form.phone_number = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
        @purchase_form.phone_number = '090123456'
        @purchase_form.phone_number = '090123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number is invalid")
      end
      it "tokenが空では登録できないこと" do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect( @purchase_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
