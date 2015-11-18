# encoding: UTF-8

require 'securerandom'

# user model
class User < ActiveRecord::Base
  has_many :twits
  validates :name, presence: true, length: { minimum: 2 }, uniqueness: true
  before_create :set_token

  private

  def set_token
    self.token = generate_token if token.blank?
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/, '')
  end
end
