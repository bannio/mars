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
  	FactoryGirl.create(:email, 
  									from: 			row[:from],
  									to:  				row[:to],
  									emailable_type: 			row[:type],
  									attachment: File.join(ENV['MARS_DATA'], row[:attachment]),
  									body: row[:body] )
  end
end

Then(/^I should be looking at a pdf file$/) do
  expect(current_url).to include('emails/1/download_attachment')
end