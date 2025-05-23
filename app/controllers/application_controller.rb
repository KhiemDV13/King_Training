class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # 🟢 Trả về user hiện tại nếu đang đăng nhập
    # 🟢 Dùng `@current_user ||=` giúp tránh gọi `find_by` nhiều lần
  end
end
