class ZomekiLogin::Content::User < Cms::Content
  default_scope { where(model: 'ZomekiLogin::User') }

  has_one :public_node, -> { public_state.where(model: 'ZomekiLogin::User').order(:id) },
  foreign_key: :content_id, class_name: 'Cms::Node'

  has_many :settings, -> { order(:sort_no) },
    foreign_key: :content_id, class_name: 'ZomekiLogin::Content::Setting', dependent: :destroy

  has_many :users, foreign_key: :content_id, class_name: 'ZomekiLogin::User', dependent: :destroy

  def token_key
    "user_remember_token_#{self.id}"
  end

  def redirect_url
    setting_value(:redirect_url)
  end

end