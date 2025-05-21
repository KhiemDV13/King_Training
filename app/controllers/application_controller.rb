class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def hello
    render html: "Hello, this is just an empty website, please add [/static_pages/home] to access our homepage"
  end
end
