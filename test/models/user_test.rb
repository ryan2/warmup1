require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    
    test "add" do
        output = User.add("ryan","ryan")
        assert output == 1
    end

    test "add same user" do
        User.add("ryan", "ryan")
        output = User.add("ryan", "ryan")
        assert output == -2
    end

    test "login" do
        User.add("ryan","ryan")
        output = User.login("ryan", "ryan")
        assert output == 2
    end

    test "wrong pw" do
        User.add("ryan","ryan")
        output = User.login("ryan", "hi")
        assert output == -1
    end
        
    test "no username" do
        output = User.login("hi", "ryan")
        assert output == -1
    end
        
    test "bad username" do
        output = User.add("","ryan")
        assert output == -3
    end

    test "reset" do
        User.add("ryan","ryan")
        User.TESTAPI_resetFixture
        output = User.add("ryan", "ryan")
        assert output == 1
    end

    test "bad pw" do
        pw = "ryan" * 128
        output = User.add("ryan", pw)
        assert output == -4
    end

    test "long username" do
        username = "ryan" * 128
        output = User.add(username, "ryan")
        assert output == -3
    end

    test "add add login" do
        User.add("ryan", "ryan")
        User.add("sam", "sam")
        output = User.login("ryan","ryan")
        assert output == 2
    end

end
