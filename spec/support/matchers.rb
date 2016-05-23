RSpec::Matchers.define :allow_param do |*args|
  match do |permission|
    # permission.allow_param?(*args).should be_true
    expect(permission.allow_param?(*args)).to be_truthy
  end
end

RSpec::Matchers.define :allow_action do |*args|
  match do |permission|
    # permission.allow?(*args).should be_true
    expect(permission.allow?(*args)).to be_truthy
  end
end
