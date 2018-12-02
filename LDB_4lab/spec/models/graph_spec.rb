require_relative '../rails_helper'

describe Graph do
  let(:gr){described_class.new}

  let(:prm){
    prm = instance_double("ProjectManager")
    allow(prm).to receive(:gen_projects_and_members_hash).and_return({"prj1" => 324, "prj2" => 337, "prj3" => 120})
    prm
  }

  it "returns correct graph info" do
    expect(gr.create_projects_and_members_graph(prm)).to eq([337, 781, 3, {"prj1" => 324, "prj2" => 337, "prj3" => 120}])
  end

  it "calls correct methods" do
    gr.create_projects_and_members_graph(prm)
    expect(prm).to have_received(:gen_projects_and_members_hash).with(no_args)
  end
end
