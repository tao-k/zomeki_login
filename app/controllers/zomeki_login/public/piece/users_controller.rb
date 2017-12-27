class ZomekiLogin::Public::Piece::UsersController < Sys::Controller::Public::Base
  include ZomekiLogin::Auth::Base

  def pre_dispatch
    @content = ::ZomekiLogin::Content::User.find_by(id: Page.current_piece.content_id)
    return http_error(404) unless @content
  end

  def index
    @login_user = login_user(@content)
    @node = @content.public_node
    if @node
      @login_uri = "#{@node.public_uri}login"
      @logout_uri = "#{@node.public_uri}logout"
    end
  end

end