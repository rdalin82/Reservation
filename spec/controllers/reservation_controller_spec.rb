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
  end
end
