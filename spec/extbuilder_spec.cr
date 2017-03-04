require "./spec_helper"

ExtBuilder.ext "#{__DIR__}/extsrc", static: true, output: "./ext"
lib Test
  fun test = "some_c_func" : Int32
end

describe ExtBuilder do
  # TODO: Write tests

  it "works" do
    Test.test.should eq(42)
  end
end
