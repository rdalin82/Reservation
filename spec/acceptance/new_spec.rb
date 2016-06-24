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
      select("06 AM", :from=>"date[hour]")
      click_button("Reserve")
    end
    expect(page).to have_content "John"
  end
  it "should have error messages" do 
    visit "/reservation/new"
    within("form") do 
      click_button("Reserve")
    end
    expect(page).to have_content "can't be blank"
  end
  it "should have an error for no tables available" do 
    20.times { |x| Table.create(time: 1, size: 4, date: "2018-09-22") }
    visit "reservation/new"
    within("form") do 
      fill_in("reservation[name]", :with=>"John")
      select(1, :from=>"reservation[seats]")
      fill_in("reservation[date]", :with=>"2018-09-22")
      select("01 AM", :from=>"date[hour]")
      click_button("Reserve")
    end
    expect(page).to have_content "No tables available" 
  end
end