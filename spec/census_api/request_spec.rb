require 'spec_helper'

describe CensusApi::Request do

  context "#find" do
    [{:source => 'sf1', :field => 'P0010001', :results=> [
        {"P0010001"=>"37253956", "name"=>"California", "state"=>"06"},
        {"P0010001"=>"1510271", "name"=>"Alameda County", "state"=>"06", "county"=>"001"}
      ]},
      {:source => 'acs5', :field => 'B00001_001E', :results =>[
        {"B00001_001E"=>"2330290", "name"=>"California", "state"=>"06"},
        {"B00001_001E"=>"92854", "name"=>"Alameda County, California", "state"=>"06", "county"=>"001"}
      ]}
    ].each do |test|
    
      describe "#{test[:source]} for a geography type" do
        use_vcr_cassette "#{test[:source]}_find_states"

        before(:each) do
          params = {:key=> api_key, :fields => test[:field], :level => 'STATE', :within=>[]}
          @collection = CensusApi::Request.find(test[:source], params)      
        end

        it 'should have 52 results' do
          @collection.count.should == 52
        end
      
        it 'should include fields for each result' do
          @collection.each do |result|
            result.should include(test[:field])
            result.should include('name')
            result.should include('state')
          end
        end
      end
    
      describe "#{test[:source]} for a geography type and id" do
        use_vcr_cassette "#{test[:source]}_find_state_with_id"

        before(:each) do
          params = {:key=> api_key, :fields => test[:field], :level => 'STATE:06', :within=>[]}
          @collection = CensusApi::Request.find(test[:source], params)      
        end

        it 'should have one result' do
          @collection.count.should == 1
        end
      
        it 'should include fields for each result' do
          @collection.each do |result|
            result.should == test[:results][0]
          end
        end
      end
    
      describe "#{test[:source]} for a geography type in a geography type" do
        use_vcr_cassette "#{test[:source]}_find_counties_in_state"

        before(:each) do
          params = {:key=> api_key, :fields => test[:field], :level => 'COUNTY', :within=>['STATE:06']}
          @collection = CensusApi::Request.find(test[:source], params)      
        end

        it 'should have one result' do
          @collection.count.should == 58
        end

        it 'should include fields for each result' do
          @collection.each do |result|
            result.should include(test[:field])
            result.should include('name')
            result.should include('state')
          end
        end
      end
     
      describe "#{test[:source]} for a geography type and id in a geography type" do
        use_vcr_cassette "#{test[:source]}_find_county_in_state"

          before(:each) do
            params = {:key=> api_key, :fields => test[:field], :level => 'COUNTY:001', :within=>['STATE:06']}
            @collection = CensusApi::Request.find(test[:source], params)      
          end
        
          it 'should have one result' do
            @collection.count.should == 1
          end
        
          it 'should include fields for each result' do
            @collection.each do |result|
              result.should == test[:results][1]
            end
          end

        end
      # FIXME: no 'end' here: why not?
    end
  end

  context "#format" do
    it 'should add wildcard after reformatting geography type without id' do
      CensusApi::Request.format('COUSUB', false).should == 'county+subdivision:*'
    end

    it 'should maintain geography id after reformatting geography type' do
      CensusApi::Request.format('COUSUB:86690', false).should == 'county+subdivision:86690'
    end

    it 'should truncate geography type AIANNH' do
      CensusApi::Request.format('AIANNH', true).should == 'american+indian+area:*'
    end

    it 'should not truncate geography type CBSA' do
      CensusApi::Request.format('CBSA', true).should == 'metropolitan+statistical+area/micropolitan+statistical+area:*'
    end
  end
end