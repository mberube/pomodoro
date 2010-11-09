class User < ActiveRecord::Base
  has_many :authorizations
  has_many :pomodoro

  def self.create_from_hash!(hash)
    name = hash['user_info']['name']
    name ||= hash['user_info']['email'] # name is replaced by email if available
    create(:name => name)
  end
end
