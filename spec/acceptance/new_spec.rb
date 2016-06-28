require "rails_helper"

describe "visit new page path", :type => :feature do 
  let (:date_in_the_future) {"2019-06-22" }
  before do 
    Timecop.freeze(Time.local(2015))
  end
  after do 
    Timecop.return
  end
  it "has new reservation heading" do 
    visit "/reservation/new"
    expect(page).to have_content "Enter in a new reservation" 
  end
  it "should be able to create a new reservation" do 
    visit "/reservation/new"
    within("form") do 
      fill_in("reservation[name]", :with=>"John")
      select(1, :from=>"reservation[seats]")
      fill_in("reservation[date]", :with=>date_in_the_future)
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
    20.times { |x| Table.create(time: 1, size: 4, date: date_in_the_future) }
    visit "reservation/new"
    within("form") do 
      fill_in("reservation[name]", :with=>"John")
      select(1, :from=>"reservation[seats]")
      fill_in("reservation[date]", :with=>date_in_the_future)
      select("01 AM", :from=>"date[hour]")
      click_button("Reserve")
    end
    expect(page).to have_content "No tables available" 
  end
end