class UsersController < ApplicationController
    
    def index
        @Users = User.all
    end
    
    def add
        @result = User.add(params[:user], params[:password])
        if @result > 0
        #     render :json => {:errCode => @result, :count => @result}
            @name = User.find_by_user(params[:user])
            render :add
        else
        #    render :json => {:errCode => @result}
            render :index
        end
    end
    
    def login
        @result = User.login(params[:user], params[:password])
        if @result > 0
        #    render :json => {:errCode => 1, :count => @result}
            @name = User.find_by_user(params[:user])
            render :login
        else
        #    render :json => {:errCode => @result}
            render :index
        end
    end
    
    def reset
        User.TESTAPI_resetFixture
        #render :json => {:errCode => 1}
        @result = -5
        render :index
    end
    
    def unitTests
	  	out = `ruby -Itest test/models/user_test.rb`
	  	tests = result.scan(/\d+ tests/).second.split.first.to_i
	  	fails = result.scan(/\d+ failures/).first.split.first.to_i
	  	render json: {output: out, totalTests: tests, nrFailed: fails}
  	end
    
end

