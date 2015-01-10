class User < ActiveRecord::Base
  has_many :passes
  attr_accessor :password, :password2
end
