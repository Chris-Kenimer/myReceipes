require "test_helper"

class ChefTest <ActiveSupport::TestCase
    def setup
        @chef = Chef.new(chefname: "John", email: "john@email.com")
    end 
    
    
    test "Chef should be valid" do
        assert @chef.valid?    
    end
    test "Chef name should be present" do
        @chef.chefname = " "
        assert_not @chef.valid?
    end
    test "Chefname should not be too long" do
        @chef.chefname = "a" * 51
        assert_not @chef.valid?
    end
    test "Chefname should not be too short" do
        @chef.chefname = "aa"
        assert_not @chef.valid?
    end
    test "email name should be present" do
        @chef.email = " "
        assert_not @chef.valid?
    end
    test "email should not be too long" do
        @chef.email = "a" * 101 + "@example.com"
        assert_not @chef.valid?
    end
    test "email must be unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    
    test "email must be valid" do
        valid_addresses = %w[user@eeee.com R_TTD-DS@eeee.hello.org user@example.com first.lastname@asdf.ed.ud laura+joe@monk.com]
        valid_addresses.each do |va|
            @chef.email = va 
        assert @chef.valid?, '#{va.inspect} should be valid'
        end
    end
    test "email valid should reject invalid addresses" do 
        invalid_addresses = %w[user@example,com user_at_as.org username@example. eeasdf@I_am_id asdf@asdf+asdf.com]    
        invalid_addresses.each do |ia|
            @chef.email = ia
        assert_not @chef.valid?, '#{ia.inspect} should be valid'
        end
    end
    
end
