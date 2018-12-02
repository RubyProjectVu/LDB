require_relative '../rails_helper'

describe Graph do
  let(:gr){described_class.new}

  let(:pjd){
    pjd = instance_double("ProjectManager")
    allow(pjd).to receive(:load_projects_and_members).and_return({"prj1" => 324, "prj2" => 337, "prj3" => 120})
    pjd
  }

  it "creates projects and members graph" do
    expect(gr.create_projects_and_members_graph(pjd)).to eq([337, 781, {"prj1" => 324, "prj2" => 337, "prj3" => 120}])
  end
end
