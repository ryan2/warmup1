class UsersController < ApplicationController
    
    def index
    end
    
    def add
        result = User.add(params[:user], params[:password])
        if result > 0
            render :json => {:errCode => result, :count => result}
        else render :json => {:errCode => result}
        end
    end
    
    def login
        result = User.login(params[:user], params[:password])
        if result > 0
            render :json => {:errCode => 1, :count => result}
        else render :json => {:errCode => result}
        end
    end
    
    def reset
        User.TESTAPI_resetFixture
        render :json => {:errCode => 1}
    end
    
    def unitTests
	  	result = `ruby -Itest test/models/user_test.rb`
	  	tests = result.scan(/\d+ tests/).second.split.first.to_i
	  	fails = result.scan(/\d+ failures/).first.split.first.to_i
	  	render json: {output: result, totalTests: tests, nrFailed: fails}
  	end
    
end

