class ZomekiLogin::Public::Node::UsersController < Cms::Controller::Public::Base
  include ZomekiLogin::Auth::Base
  protect_from_forgery :except => [:login]

  def pre_dispatch
    @content = ::ZomekiLogin::Content::User.find_by(id: Page.current_node.content.id)
    return http_error(404) unless @content
  end

  def login
    return unless request.post?
    if user = authenticate(params[:account], params[:password], @content)
      sign_in(@content, user)
      return redirect_to @content.redirect_url
    else
      flash[:notice] = "ログインに失敗しました。ユーザーIDとパスワードを確認してください。"
      return
    end
  end

  def logout
    if user = login_user(@content)
      sign_out(@content, user)
    else
      flash[:notice] = "ログインしてください。"
    end
    return redirect_to "#{Page.current_node.public_uri}login"
  end

end