require "rails_helper"

describe "visit new page path", :type => :feature do 
  it "has new reservation heading" do 
    visit "/reservation/new"
    expect(page).to have_content "Enter in a new reservation" 
  end
  it "should be able to create a new reservation" do 
    visit "/reservation/new"
    within("form") do 
      fill_in("reservation[name]", :with=>"John")
      select(1, :from=>"reservation[seats]")
      fill_in("reservation[date]", :with=>"2016-09-22")
      select("6 AM", :from=>"date[hour]")
      click_button("Reserve")
    end
    expect(page).to have_content "John"
  end
end