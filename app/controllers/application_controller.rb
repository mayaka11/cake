class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    customer_path(current_customer.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def current_cart
    if current_user
      # ユーザーとカートの紐付け
      current_cart = current_user.cart || current_user.create_cart!
    else
      # セッションとカートの紐付け
      current_cart = Cart.find_by(id: session[:cart_id]) || Cart.create
      session[:cart_id] ||= current_cart.id
    end
    current_cart
  end

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kana])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:telephone_number])
  end

end
