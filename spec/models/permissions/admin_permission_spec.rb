require "spec_helper"

describe Permissions::AdminPermission do
  subject { Permissions.permission_for(build(:user, roles_mask: 1)) }

  it "allows anything" do
    should allow(:any, :thing)
    should allow_param(:any, :thing)
  end
end