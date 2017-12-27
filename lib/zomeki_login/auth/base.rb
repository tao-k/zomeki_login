module ZomekiLogin::Auth::Base

  def authenticate(account, password, content)
    return nil if account.blank? || password.blank?
    content.users.where(state: 'enabled', account: account, password: password).first
  end

  def login_user(content)
    return nil if cookies[:login_account].blank? || cookies[:user_remember_token].blank?
    content.users
      .where(ZomekiLogin::User.arel_table[:remember_token].not_eq(nil))
      .where(account: cookies[:login_account])
      .where(remember_token: cookies[:user_remember_token]).first
  end

  def sing_in(content, user)
    remember_token = user.new_remember_token(2.weeks.from_now.utc)
    cookies[:login_account] = {value: user.account, expires: 90.day.from_now }
    cookies[:user_remember_token] = {value: remember_token, expires: 90.day.from_now }
    user.update_columns(remember_token: remember_token)
  end

  def sing_out(content, user)
    user.update_columns(remember_token: nil)
    cookies.delete(:login_account)
    cookies.delete(:user_remember_token)
  end

end
