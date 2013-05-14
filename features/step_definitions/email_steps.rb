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
