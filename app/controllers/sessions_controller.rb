class SessionsController < ApplicationController
  # 🔹 `SessionsController` kế thừa từ `ApplicationController`, giúp sử dụng các chức năng chung

  def new
    @user = User.new
    # 🟢 `new` tạo một user mới nhưng chưa lưu vào database
    # 🟢 Action `new` chỉ hiển thị form đăng nhập (`views/sessions/new.html.erb`)
  end

  def create
    user = User.find_by(email: params[:email])
    # 🟢 Tìm user theo email mà người dùng nhập vào trong form login
    # 🟢 `find_by(email: params[:email])` trả về `nil` nếu không tìm thấy user

    if user && user.authenticate(params[:password])
      # 🟢 Kiểm tra nếu user tồn tại (`user != nil`) và mật khẩu đúng (`authenticate`)
      session[:user_id] = user.id
      # 🟢 Lưu user_id vào session để ghi nhớ đăng nhập
      flash[:success] = "Welcome back, #{user.name}!"
      # 🟢 Hiển thị thông báo flash chào mừng user
      redirect_to user
      # 🟢 Chuyển hướng đến trang profile của user
    else
      flash[:danger] = "Invalid email or password!"
      # 🔴 Nếu đăng nhập thất bại, hiển thị lỗi
      render "new", status: :unprocessable_entity
      # 🔴 Hiển thị lại form đăng nhập kèm thông báo lỗi
    end
  end

  def destroy
    session[:user_id] = nil
    # 🟢 Xóa user_id khỏi session để đăng xuất
    flash[:success] = "You have logged out!"
    # 🟢 Hiển thị thông báo đăng xuất
    redirect_to root_path
    # 🟢 Quay lại trang chính
  end
end
