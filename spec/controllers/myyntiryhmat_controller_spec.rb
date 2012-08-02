require 'spec_helper'

describe MyyntiryhmatController do

  describe "GET 'ryhmavaihto'" do
    it "returns http success" do
      get 'ryhmavaihto'
      response.should be_success
    end
  end

  describe "GET 'aikavaihto'" do
    it "returns http success" do
      get 'aikavaihto'
      response.should be_success
    end
  end

  describe "GET 'myyjavaihto'" do
    it "returns http success" do
      get 'myyjavaihto'
      response.should be_success
    end
  end

end
