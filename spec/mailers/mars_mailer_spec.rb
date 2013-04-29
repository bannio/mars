require "spec_helper"

describe MarsMailer do
  describe "quotation_email" do
    let(:mail) { MarsMailer.quotation_email }

    it "renders the headers" do
      mail.subject.should eq("Quotation email")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
