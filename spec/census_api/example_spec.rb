require 'spec_helper'

describe 'CensusApi::Examples', :vcr do
  let(:client) { CensusApi::Client.new(api_key) }

  describe 'sf1' do
    before(:each) do
      client.dataset = 'sf1'
    end
    describe '#find' do
      CensusExamples::SF1.each do |query|
        it "should retrieve #{query.join(",")}" do
          response = client.send(:find, query[0], query[1], query[2])
          expect{ response }.not_to raise_error
          response.should be_a(Array)
          response.first.should include('name')
        end
      end
    end
    describe '#where' do
      CensusExamples::SF1.each do |query|
        it "should retrieve #{query.join(",")}" do
          response = client.send(:where, {fields: query[0], level: query[1], within: query[2]})
          expect{ response }.not_to raise_error
          response.should be_a(Array)
          response.first.should include('name')
        end
      end
    end
  end

  describe 'acs5' do
    before(:each) do
      client.dataset = 'acs5'
    end
    describe '#find' do
      CensusExamples::ACS5.each do |query|
        it "should retrieve #{query.join(",")}" do
          response = client.send(:find, query[0], query[1], query[2])
          expect{ response }.not_to raise_error
          response.should be_a(Array)
          response.first.should include('name')
        end
      end
    end
    describe '#where' do
      CensusExamples::ACS5.each do |query|
        it "should retrieve #{query.join(",")}" do
          response = client.send(:where, {fields: query[0], level: query[1], within: query[2]})
          expect{ response }.not_to raise_error
          response.should be_a(Array)
          response.first.should include('name')
        end
      end
    end
  end
end