require 'spec_helper'

describe Project do
  before(:each) do
    @attr = { 
      code: "P001",
      name: "My project",
      start_date: "2013-04-01",
      end_date: '',
      completion_date: '',
      status: "open",
      value: 10000,
      company_id: create(:company).id,
      notes: 'some words' 
    }
  end
  
  it "should be valid with valid attributes" do
    project = Project.new(@attr)
    project.should be_valid
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
    project = Project.new(@attr.merge(start_date: '2013-12-25', end_date: '2012-12-25'))
    project.should_not be_valid
  end
  
  # the date fields will not allow an invalid date to be inserted by new so not readily tested for validity
  # Also, by using the jquery-ui datepicker, a user cannot enter an invalid date in any case.
  # 
  # it "start_date must be a valid date" do
  #   project = Project.new(@attr)
  #   project.start_date = '1999-99-99'
  #   project.should_not be_valid
  # end
  # 
  # it "end_date must be a valid date (or blank)" do
  #   project = Project.new(@attr)
  #   project.end_date = '1999-99-99'
  #   project.should_not be_valid
  # end
  # 
  # it "completion_date must be a valid date (or blank)" do
  #   project = Project.new(@attr)
  #   project.completion_date = '1999-99-99'
  #   project.should_not be_valid  
  # end
  
end
