require "spec_helper"

describe MarsMailer do
 describe "quotation_email" do
    let (:quote) { FactoryGirl.create(:quotation)}
    let(:mail) { MarsMailer.quotation(from:       'from@example.com',
                                      to:         'to@example.com',
                                      subject:    'Quotation email',
                                      body:       'Hi',
                                      id:         quote.id,
                                      attachment: 'SQ001.pdf') }

    it "renders the headers" do
      mail.subject.should eq("Quotation email")
      mail.to.should eq(["to@example.com"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
