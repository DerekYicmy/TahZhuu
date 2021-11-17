require "digest"

class User < ApplicationRecord
  validates :username, presence: true
  #validates (:username, { presence: true })
  validates :email, presence: true, uniqueness: true 
  #format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  #ref:https://stackoverflow.com/questions/4776907/what-is-the-best-easy-way-to-validate-an-email-address-in-ruby

  def self.login(user_info)
    email = user_info[:email]
    password = user_info[:password]
    salted_password = "x#{password}yz"
    encrypted_password = Digest::SHA1.hexdigest(salted_password)
    #self.password= Digest::SHA1.hexdigest(salted_password)
    self.find_by(email: email, password: encrypted_password)
  end



  before_create :encrypt_password
  #callback method/function 

  private
  def encrypt_password
    salted_password= "x#{self.password}yz"
    self.password = Digest::SHA1.hexdigest(salted_password)
    #self.password.reverse
    #encrypted_password = Digest::SHA1.hexdigest(salted_password)
    #setter(first self.password)  #getter(2nd self.password)
    #xx1111h5 <--- add eandom str at the front and end "salting encryption"
  end
 
end

