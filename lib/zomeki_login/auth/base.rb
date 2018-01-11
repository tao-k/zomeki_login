module ZomekiLogin::Auth::Base
  ACCOUNT_KEY = :login_account
  TOKEN_KEY   = :user_remember_token

  def authenticate(account, password, content)
    return nil if account.blank? || password.blank?
    content.users.where(state: 'enabled', account: account, password: password).first
  end

  def login_user(content)
    return nil if cookies[ACCOUNT_KEY].blank? || cookies[TOKEN_KEY].blank?
    content.users
      .where(Login::User.arel_table[:remember_token].not_eq(nil))
      .where(account: cookies[ACCOUNT_KEY])
      .where(remember_token: cookies[TOKEN_KEY]).first
  end

  def sign_in(content, user)
    remember_token = user.new_remember_token(2.weeks.from_now.utc)
    cookies[ACCOUNT_KEY] = {value: user.account, expires: 90.day.from_now }
    cookies[TOKEN_KEY] = {value: remember_token, expires: 90.day.from_now }
    user.update_columns(remember_token: remember_token)
  end

  def sign_out(content, user)
    user.update_columns(remember_token: nil)
    cookies.delete(ACCOUNT_KEY)
    cookies.delete(TOKEN_KEY)
  end

end
