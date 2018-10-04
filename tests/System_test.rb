require_relative '../System'

describe System do
   context "Testing" do
      it "Testing" do
         s = System.new
         expect(s.test).to be true
      end
   end
end
