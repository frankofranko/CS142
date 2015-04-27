class User < ActiveRecord::Base
    
    attr_accessor :password_temp
    
    has_many :comments
    has_many :photos
    has_many :tags

    def password_valid?(candidate_password)
        candidate_digest = Digest::SHA1.hexdigest(candidate_password+self.salt.to_s)
        return self.password_digest==candidate_digest
    end
    
    def password
        return self.password_temp
    end
    
    def password=(password)
        self.salt =  Random.rand(100000000)
        self.password_digest = Digest::SHA1.hexdigest(password + self.salt.to_s)
        self.password_temp = password
    end
    
    validates :password, confirmation: true
    validates :first_name, :last_name, :login, :password, :password_confirmation, presence: true
    validates :login, :uniqueness => {:case_sensitive => false, :message => "name is already registered."}

end
