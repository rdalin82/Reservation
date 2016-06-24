require "rails_helper"

describe "visit index page", :type => :feature do 
  it "has reservation heading" do 
    visit "/"
    expect(page).to have_content "Reservation"
  end
  it "should navigate to new reservation" do 
    visit "/" 
    click_link("New Reservation?")
    expect(page).to have_content("Enter in a new reservation")
  end
end
