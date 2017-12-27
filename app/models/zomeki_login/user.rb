class ZomekiLogin::User < ApplicationRecord
  include Sys::Model::Base
  include Sys::Model::Base::Config
  include Sys::Model::Auth::Manager
  include StateText

  # Content
  belongs_to :content, :foreign_key => :content_id, :class_name => 'ZomekiLogin::Content::User'
  validates :content_id, :presence => true

  def states
    [['有効','enabled'],['無効','disabled']]
  end

  def new_remember_token(expires)
    Util::String::Crypt.encrypt("#{account}--#{expires}")
  end

end
