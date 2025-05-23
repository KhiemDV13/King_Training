class User < ApplicationRecord
  has_many(:microposts, dependent: :destroy)
  # Thiết lập mối quan hệ với Micropost
  has_secure_password # 🛡️ Sử dụng bcrypt để mã hóa mật khẩu
  # Đảm bảo name không bị bỏ trống và có độ dài tối đa 50 ký tự, phải là duy nhất, chữ hoa chữ thường đều giống nhau
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  # Kiểm tra email không trống, không trùng lặp, và đúng định dạng, tối đá 255 kí tự
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # Đảm bảo password không bị bỏ trống và có ít nhất 6 ký tự
  validates :password, presence: true, length: { minimum: 6 }
  # Đảm bảo password_confirmation không bị bỏ trống và có độ dài tối thiểu 6 ký tự
  validates :password_confirmation, presence: true, length: { minimum: 6 }
end
