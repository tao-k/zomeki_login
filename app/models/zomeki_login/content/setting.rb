class ZomekiLogin::Content::Setting < Cms::ContentSetting
  belongs_to :content, foreign_key: :content_id, class_name: 'ZomekiLogin::Content::User'

  set_config :redirect_url,
    name: "ログイン後リダイレクトURL",
    form_type: :text_field,
    default_value: '/'

end
