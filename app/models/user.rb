class User < ActiveRecord::Base
  has_secure_password

  has_many :tweets

  def slug
    self.username.downcase.gsub(/[^0-9a-z\- ]/, "").gsub(" ", "-")
  end

  def self.find_by_slug(username)
    user = User.find{|user| user.slug == username}
  end
end
