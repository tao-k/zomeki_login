module ZomekiLogin::Auth::Base
  @@current_user = false

  def authenticate(account, password, content)
    return nil if account.blank? || password.blank?
    content.users.where(state: 'enabled', account: account, password: password).first
  end

  def login_user(content)
    content.users
      .where(ZomekiLogin::User.arel_table[:remember_token].not_eq(nil))
      .where(remember_token: cookies[content.token_key.to_sym]).first
  end

  def sing_in(content, user)
    remember_token = user.new_remember_token(2.weeks.from_now.utc)
    cookies[content.token_key.to_sym] = {value: remember_token, expires: 90.day.from_now }
    user.update_columns(remember_token: remember_token)
  end

  def sing_out(content, user)
    user.update_columns(remember_token: nil)
    cookies.delete(content.token_key.to_sym)
  end

end
