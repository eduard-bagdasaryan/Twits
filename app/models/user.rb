require 'securerandom'

class User < ActiveRecord::Base
    has_many :twits
    validates :name, presence: true,
        length: { minimum: 2 }
    before_create :set_token

    private
    def set_token
        if self.token.nil? || self.token.empty?
            self.token = generate_token
        end
    end

    def generate_token
        SecureRandom.uuid.gsub(/\-/,'')
    end
end
