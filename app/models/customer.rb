class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :cart_items, dependent: :destroy
 has_many :addresses, dependent: :destroy
 has_many :orders, dependent: :destroy



# is_deletedがfalseならtrueを返すようにしている
 def active_for_authentication?
    super && (is_deleted == false)
 end

 def status_in_japanese
  if is_deleted
      "退会"
  else
      "有効"
  end
 end
end
