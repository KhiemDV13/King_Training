require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # Def @user for each testcase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  # Test case cho việc kiểm tra tính hợp lệ của User
  test "should be valid" do
    assert @user.valid?  # Kiểm tra xem @user có hợp lệ không
  end

test "name should be present" do
 @user.name = " "  # Gán name rỗng
 assert_not @user.valid?  # Kiểm tra name không hợp lệ
end

test "email should be present" do
 @user.email = " "  # Gán email rỗng
 assert_not @user.valid?  # Kiểm tra email không hợp lệ
end

test "name should not be too long" do
 @user.name = "a" * 51  # Chuỗi 51 ký tự (quá giới hạn)
 assert_not @user.valid?  # Kiểm tra name không hợp lệ
end


test "email should not be too long" do
 @user.email = "a" * 244 + "@example.com"  # Email dài quá giới hạn 255
 assert_not @user.valid?  # Kiểm tra email không hợp lệ
end

test "email validation should accept valid addresses" do
  # 🏆 Định nghĩa một test case với mô tả "email validation should accept valid addresses"
  valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  # 🔹 Tạo một danh sách các email hợp lệ bằng %w[], giúp tạo mảng từ chuỗi nhanh gọn.
  valid_addresses.each do |valid_address|
    # 🔄 Lặp qua từng địa chỉ email trong danh sách

    @user.email = valid_address
    # ✅ Gán giá trị email cho User từ danh sách đang xét.

    assert @user.valid?, "#{valid_address.inspect} should be valid"
    # 🔍 Kiểm tra nếu User hợp lệ (`valid?` trả về true).
    # ❌ Nếu User không hợp lệ, test sẽ báo lỗi với thông điệp chứa email bị sai.
  end
end

test "email validation should reject invalid addresses" do
  # 🏆 Định nghĩa một test case với mô tả "email validation should reject invalid addresses"
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com]
  # 🔹 Tạo một danh sách các email không hợp lệ bằng %w[], giúp tạo mảng từ chuỗi nhanh gọn.
  invalid_addresses.each do |invalid_address|
    # 🔄 Lặp qua từng địa chỉ email trong danh sách
    @user.email = invalid_address
    # ✅ Gán giá trị email cho User từ danh sách đang xét.
    assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    # 🔍 Kiểm tra nếu User không hợp lệ (`valid?` trả về false).
    # ❌ Nếu User hợp lệ, test sẽ báo lỗi với thông điệp chứa email bị sai.
  end
end

test "email addresses should be unique" do
  duplicate_user = @user.dup  # Tạo một bản sao của @user
  duplicate_user.email = @user.email.upcase  # Chuyển đổi email thành chữ hoa
  @user.save  # Lưu @user vào cơ sở dữ liệu
  assert_not duplicate_user.valid?  # Kiểm tra xem bản sao có hợp lệ không
end

test "password should be present (nonblank)" do
  @user.password = @user.password_confirmation = ""  # Gán password và password_confirmation rỗng
  assert_not @user.valid?  # Kiểm tra xem @user có hợp lệ không
end

test "password should have a minimum length" do
  @user.password = @user.password_confirmation = "a" * 5  # Gán password và password_confirmation ngắn hơn 6 ký tự
  assert_not @user.valid?  # Kiểm tra xem @user có hợp lệ không
end
end
