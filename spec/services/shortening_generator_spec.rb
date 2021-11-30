# frozen_string_literal: true

require "rails_helper"

RSpec.describe ShorteningGenerator do
  # subject { RestockingShipments::CreateRestockingShipment }
  describe "generate shortening" do
    context "valid url" do
      it "returns shortening url" do
        stub_request(:get, "https://cutt.ly/api/api.php?key=test_key&short=https://google.com?q=formula1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "{\"url\":{\"status\":7,\"fullLink\":\"https://corporatefinanceinstitute.com/resources/knowledge/finance/\",\"date\":\"2021-11-28\",\"shortLink\":\"https://cutt.ly/f1\",\"title\":\"Finance Articles - Self Study Guides to Learn Finance\"}}", headers: {})
        result = ShorteningGenerator.perform("https://google.com?q=formula1")
        expect(result).to eq "https://cutt.ly/f1"
      end
    end
    context "url was already shorted" do
      it "returns nothing" do
        stub_request(:get, "https://cutt.ly/api/api.php?key=test_key&short=https://cutt.ly/f1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "{\"url\":{\"status\":1}}", headers: {})
         result = ShorteningGenerator.perform("https://cutt.ly/f1")
        expect(result).to eq nil
      end
    end
  end

  describe "errors handle" do
    context "Invalid JSON" do
      it "returns nothing" do
        stub_request(:get, "https://cutt.ly/api/api.php?key=test_key&short=https://cutt.ly/f1").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "Something went wrong", headers: {})
        expect { ShorteningGenerator.perform("https://cutt.ly/f1") }.to raise_error(ShorteningGenerator::InvalidJSON)
      end
    end
    context "network problems" do
      it "raise an exception" do
        expect(HTTParty).to receive(:get).and_raise(Net::OpenTimeout)
        expect { ShorteningGenerator.perform("url") }.to raise_error(ShorteningGenerator::ConnectionError)
      end
    end
  end
end

