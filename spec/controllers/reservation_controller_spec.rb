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
end
