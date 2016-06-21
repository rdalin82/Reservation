require 'rails_helper'

RSpec.describe ReservationController, type: :controller do
  describe "Get Index" do 
    it "has an index" do 
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("index")
    end
  end
  describe "New Reservation" do 
    it "has a new form" do 
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end
  end
  describe "Create new reservation", :type => :request do 
    it "saves a valid reservation" do 
      post "/reservation", reservation: {name: "Rob", seats: 4, time: 1 }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
      follow_redirect!
    end
    it "does not save an invalid reservation" do 
      post "/reservation", reservation: {name: nil, seats: nil, time: nil}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_reservation_path)
      follow_redirect!
      expect(flash[:warning].nil?).to eq(false)
    end
    it "should stop at the table limit" do 
      post "/reservation", reservation: { name: "Rob", seats: 81, time: 1 }
      expect(response).to have_http_status(302)
      expect(flash[:warning][0]).to include("No tables")
    end
    it "should not post if there are too many existing tables" do 
      20.times { |x| Table.create(time: 1, size: 4) }
      post "/reservation", reservation: { name: "Robb", seats: 4, time: 1 }
      expect(response).to have_http_status(302)
      expect(flash[:warning][0]).to include("No tables")
    end
  end
end
