class ZomekiLogin::Admin::Content::BaseController < Cms::Admin::Content::BaseController
  layout  'admin/cms'
  def model
    ZomekiLogin::Content::User
  end

end