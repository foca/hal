require "hal"
require "spec"

describe HAL do
  class User < Struct.new(:name); end
  class Admin; end

  include HAL

  before do
    HAL.rules_for User do
      def read?
        true
      end

      def write?
        false
      end
    end

    HAL.rules_for Admin do
      def read?
        true
      end

      def write?
        true
      end
    end
  end

  let :john do
    User.new("John")
  end

  let :dave do
    User.new("Dave")
  end

  let :admin do
    Admin.new
  end

  it "uses the correct rules to check permissions" do
    can(john).write?.should be(false)
    can(admin).write?.should be(true)
  end

  it "raises an exception when enforcing an invalid rule" do
    expect { can!(john) {|can| can.write? } }.to raise_exception(HAL::ICantLetYouDoThat)
  end

  it "makes available the subject object inside the rules" do
    HAL.rules_for User do
      def open_the_pod_bay_doors?
        subject.name != "Dave"
      end
    end

    can(dave).open_the_pod_bay_doors?.should be(false)
    can(john).open_the_pod_bay_doors?.should be(true)
  end
end
