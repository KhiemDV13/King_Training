class UsersController < ApplicationController
  # 🔹 `UsersController` kế thừa từ `ApplicationController`, giúp sử dụng các chức năng chung của ứng dụng

  def show
    @user = User.find(params[:id])
    # 🟢 `show` lấy thông tin của user có `id` từ params và gán vào `@user`
    # 🟢 Khi gọi `/users/:id`, Rails sẽ tìm user với id đó trong database
    # 🟢 Nếu tìm thấy, `@user` được hiển thị trong view `users/show.html.erb`
  end

  def new
    @user = User.new
    # 🟢 `new` tạo một user mới nhưng chưa lưu vào database
    # 🟢 `@user` giúp form đăng ký (`users/new.html.erb`) có dữ liệu trống để người dùng nhập vào
  end

  def create
    @user = User.new(user_params)
    # 🟢 `create` khởi tạo một user mới từ dữ liệu nhận được trong `user_params`
    # 🟢 `user_params` đảm bảo chỉ nhận các field hợp lệ để tránh lỗi bảo mật

    if @user.save
      flash[:success] = "Welcome to the App, #{@user.name}!"
      # 🟢 Nếu user được lưu thành công, hiển thị flash message chào mừng
      redirect_to @user
      # 🟢 Chuyển hướng đến trang profile của user (`users/show.html.erb`)
    else
      render "new", status: :unprocessable_entity
      # 🔴 Nếu có lỗi (ví dụ: thiếu tên, email không hợp lệ), render lại form đăng ký (`users/new.html.erb`)
      # 🔴 `unprocessable_entity` (422) báo cho trình duyệt biết dữ liệu không hợp lệ
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # 🛡️ `user_params` dùng để bảo vệ dữ liệu, chỉ cho phép các field `name`, `email`, `password`, `password_confirmation`
    # 🛡️ `require(:user)` đảm bảo params chứa `user` trước khi lấy dữ liệu bên trong
    # 🛡️ `permit(...)` chỉ cho phép những trường hợp lệ để tránh tấn công (mass-assignment vulnerability)
  end
end
