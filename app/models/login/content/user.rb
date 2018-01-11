class Login::Content::User < Cms::Content
  default_scope { where(model: 'Login::User') }

  has_one :public_node, -> { public_state.where(model: 'Login::User').order(:id) },
  foreign_key: :content_id, class_name: 'Cms::Node'

  has_many :settings, -> { order(:sort_no) },
    foreign_key: :content_id, class_name: 'Login::Content::Setting', dependent: :destroy

  has_many :users, foreign_key: :content_id, class_name: 'Login::User', dependent: :destroy

  def redirect_url
    setting_value(:redirect_url)
  end

end