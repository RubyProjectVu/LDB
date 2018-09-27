require 'rspec'
require 'Projektas'

context "pasidalinam po 10 testuku kiekvienam" do
  it "turetu baigtis gerai" do
    proj = Projektas.new
    proj.dosth
    expect(proj.some_attribute).to be false
    end 
end
