require 'spec_helper'

describe Project do
  before(:each) do
    @attr = { 
      code: "P001",
      name: "My project",
      start_date: "2013-04-01",
      end_date: "2014-04-01",
      completion_date: "",
      status: "open",
      value: 10000,
      company_id: create(:company).id,
      notes: 'some words' 
    }
  end
  
  it "should require a company_id" do
    project = Project.new(@attr.merge(company_id: ''))
    project.should_not be_valid
  end
  
  it "should require a code" do
    project = Project.new(@attr.merge(code: ''))
    project.should_not be_valid
  end

  it "should require a name" do
    project = Project.new(@attr.merge(name: ''))
    project.should_not be_valid
  end
  
  it "end_date cannot be before start_date" do
    pending
  end
  
  it "start_date must be a valid date" do
    pending
  end
  
  it "end_date must be a valid date or blank" do
    pending
  end
  
  it "completion_date must be a valid date or blank" do
    pending
  end  
  
  it "calculates the next project code" do
    pending
  end
  
end
