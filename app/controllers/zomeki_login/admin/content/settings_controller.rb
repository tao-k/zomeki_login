class ZomekiLogin::Admin::Content::SettingsController < Cms::Admin::Content::SettingsController
  def model
    ZomekiLogin::Content::Setting
  end
end
