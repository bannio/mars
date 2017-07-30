Given(/^the quotation has the following lines$/) do |table|
  table.hashes.each do |row|
    Quotation.find_by_code(row[:code]).quotation_lines.create!(
                        name:         row[:name],
                        description:  row[:description],
                        quantity:     row[:quantity],
                        unit_price:   row[:unit_price])
  end
end

Then(/^I should be on the email page$/) do
  # page.should have_selector('#new_email_page')
  expect(current_path).to eq(new_email_path)
end

Given(/^I have the following emails$/) do |table|
  table.hashes.each do |row|
    case row[:type]
    when "Quotation"
      emailable = create(:quotation)
    when "SalesOrder"
      emailable = create(:sales_order)
    end
  	FactoryGirl.create(:email,
  									from: 			row[:from],
  									to:  				row[:to],
  									emailable_type: 			row[:type],
                    emailable: emailable,
  									attachment: File.join(ENV['MARS_DATA'], row[:attachment]),
  									body: row[:body] )
  end
end

Then(/^I should be looking at a pdf file$/) do
  expect(current_url).to include("emails/#{@email[0].id}/download_attachment")
end

When(/^I visit the "([^"]*)" email page$/) do |arg1|
  @email = Email.search(arg1)
  visit "/emails/#{@email[0].id}"
end