class PermissionService 
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    return true if controller == "stores" && action.in?(%w(show index))
    return true if controller == "sessions" && action.in?(%w(create new))

    if user.admin?
      return true if controller == "items" && action.in?(%w(show index))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "orders" && action.in?(%w(index))
      return true if controller == "users" && action.in?(%w(show index))
    elsif user.store_admin?
      return true if controller == "items" && action.in?(%w(show index))
      return true if controller == "sessions" && action.in?(%w(destroy))
    elsif user.registered_user?
      return true if controller == "items" && action.in?(%w(show index))
      return true if controller == "sessions" && action.in?(%w(destroy))
      return true if controller == "orders" && action.in?(%w(index))
    end
  end

  private
  attr_reader :user, :controller, :action
end