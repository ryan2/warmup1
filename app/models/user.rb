class User < ActiveRecord::Base
    
    SUCCESS = 1
    ERR_BAD_CREDENTIALS = -1 # no id/pw match
    ERR_USER_EXISTS = -2 # id exists when adding
    ERR_BAD_USERNAME = -3 # Empty string and Max 128 char.
    ERR_BAD_PASSWORD = -4 # invalid password length for add
    MAX_USERNAME_LENGTH = 128
    MAX_PASSWORD_LENGTH = 128
    
    def self.add(u, p)
        if !User.find_by_user(u).nil?
            return ERR_USER_EXISTS
        end
        if u.blank? or u.length > MAX_USERNAME_LENGTH
            return ERR_BAD_USERNAME
        end
        if p.length > MAX_PASSWORD_LENGTH
            return ERR_BAD_PASSWORD
        else
            @user = User.new(:user => u,:password => p, :count =>1)
            @user.save
            return SUCCESS
        end
    end

    def self.login(u,p)
        @user = User.find_by_user(u)
        if @user.nil? or p!=@user.password
            return ERR_BAD_CREDENTIALS
        else
            @user.count+=1
            @user.save
            return @user.count
        end
    end

    def self.TESTAPI_resetFixture
        User.delete_all
        return SUCCESS
    end

end