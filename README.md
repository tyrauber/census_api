# Census API

This gem provides a Ruby wrapper around the Census Bureau API.


## Obtaining an API key

To be able to use this gem, you'll need a Census Bureau API key. To request an API key, visit
http://www.census.gov/developers/tos/key_request.html and follow the instructions.


## Installing the gem

To use this gem, install it with <tt>gem install census_api</tt> or add it to your Gemfile:

  gem 'cemsus_api'

And install it with <tt>bundle install</tt>

## Usage

### Retrieving Census Data

First register a new Client:

@client = CensusApi::Client.new(API_KEY)

To query the 2010 Census SF1 dataset:

@client.sf1(fields, for, in*)

#### Parameters

The 'fields' parameter is a comma separated string of SF1 field names.

The 'for' parameter is a single geography type, and optionally, the geography ids (geoid) for specific geographies of that type. A colon separates the geography type from the id and a comma separates ids.

For example, 'STATE:06,02' would reference the state of California and Alaska.

The 'in' parameter is a set of geography types or geography. Similar to the 'for' parameter, a colon separates the geography type from the id and a comma separates ids. Sets of geography are separated by a plus symbol.

For example, 'STATE:02+COUNTY:290' would reference the 'Yukon-Koyukuk Census Area' County in the state of Alaska.

The 'in' parameter is optional, or required, depending upon the geography type. The smaller the geography type being required, the more the request must be restricted by the 'in' parameter.

### Census 2010 SF1 Examples and Supported Geography

#### 040   STATE   state

Retrieve fields for all States:

@client.sf1('P0010001', 'STATE')

Retrieve fields for California (geoid: 06):

@client.sf1('P0010001', 'STATE:06')

Retrieve fields for California and Alaska:

@client.sf1('P0010001', 'STATE:06,02')

#### 050   COUNTY   state-county 

Retrieve fields for all Counties:

@client.sf1('P0010001', 'COUNTY')

Retrieve fields for Counties in California:

@client.sf1('P0010001', 'COUNTY', 'STATE:06')

Retrieve fields for a specific County in California:

@client.sf1('P0010001', 'COUNTY:001', 'STATE:06')

#### 060    COUSUB   state-county-county subdivision

Retrieve fields for all County Subdivisions within a specific County:

@client.sf1('P0010001', 'COUSUB', 'STATE:02+COUNTY:290')

Retrieve fields for a specific County Subdivision within a specific County:

@client.sf1('P0010001', 'COUSUB:86690', 'STATE:02+COUNTY:290')

Note: You must also specify the State the County belongs to.

#### 067   SUBMCD   state-county-county subdivision-subminor civil subdivision

Retrieve fields for all Subminor Civil Subdivisions within a specific County Subdivision:

@client.sf1('P0010001', 'SUBMCD', 'STATE:72+COUNTY:127+COUSUB:79693')

Retrieve fields for a specific Subminor Civil Subdivisions within a specific County Subdivision:

@client.sf1('P0010001', 'SUBMCD:02350', 'STATE:72+COUNTY:127+COUSUB:79693')

#### 101   TABBLOCK   state-county-tract-block

Retrieve fields for all Blocks within a specific Tract

@client.sf1('P0010001', 'TABBLOCK', 'STATE:02+COUNTY:290+TRACT:00100')

Retrieve fields for a specific Subminor Civil Subdivisions within a specific County Subdivision:

@client.sf1('P0010001', 'SUBMCD:02350', 'STATE:72+COUNTY:127+COUSUB:79693')

#### 140   TRACT   state-county-tract

Retrieve fields for all Tracts within a specific County:

@client.sf1('P0010001', 'TRACT', 'STATE:02+COUNTY:170')

Retrieve fields for a specific Tract within a specific County:

@client.sf1('P0010001', 'TRACT:000101', 'STATE:02+COUNTY:170')

#### 150   BG   state-county- tract-block group

Retrieve fields for all Block Groups within a specific Tract:

@client.sf1('P0010001', 'BG', 'STATE:02+COUNTY:170+TRACT:000101')

Retrieve fields for a specific Block Group within a specific Tract:

@client.sf1('P0010001', 'BG:1', 'STATE:02+COUNTY:170+TRACT:000101')

#### 160   PLACE   state-place

Retrieve fields for all Places:

@client.sf1('P0010001', 'PLACE')

Retrieve fields for all Places within a specific State:

@client.sf1('P0010001', 'PLACE', 'STATE:06')

Retrieve fields for a specific place within a specific State:

@client.sf1('P0010001', 'PLACE:00135', 'STATE:06')

####   230   ANRC   state-alaska native regional corporation

Retrieve fields for all Alaska Native Regional Corporations:

@client.sf1('P0010001', 'ANRC')

Retrieve fields for all Alaska Native Regional Corporations within a specific State:

@client.sf1('P0010001', 'ANRC', 'STATE:02')

Retrieve fields for all Alaska Native Regional Corporations within a specific State:

@client.sf1('P0010001', 'ANRC:00590', 'STATE:02')

####   280   AIANNH   state-american indian area/alaska native area/hawaiian home land

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land:

@client.sf1('P0010001', 'AIANNH')

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

@client.sf1('P0010001', 'AIANNH', 'STATE:02')

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

@client.sf1('P0010001', 'AIANNH:03800', 'STATE:02')

#### ￼￼￼￼￼￼￼￼281   AITS   state-american indian area-tribal subdivision

Retrieve fields for all American Indian Area-Tribal Subdivisions:

@client.sf1('P0010001', 'AITS')

Retrieve fields for all American Indian Area-Tribal Subdivisions in a specific American Indian Area:

@client.sf1('P0010001', 'AITS', 'STATE:40+AIANNH:13735')

Retrieve fields for a specific American Indian Area-Tribal Subdivision in a specific American Indian Area:

@client.sf1('P0010001', 'AITS:83127', 'STATE:40+AIANNH:13735')

#### 320   CBSA   state-metropolitan statistical area/micropolitan statistical area

Retrieve fields from all Metropolitan Statistical Areas / Micropolitan Statistical Areas in a specific State:

@client.sf1('P0010001', 'CBSA', 'STATE:02')

Retrieve fields from a specific Metropolitan Statistical Areas / Micropolitan Statistical Areas in a specific State:

@client.sf1('P0010001', 'CBSA:11260', 'STATE:02')

#### ￼￼￼￼￼￼￼￼323   METDIV    state-metropolitan statistical area/micropolitan statistical area- metropolitan division

Retrieve fields from all Metropolitan Divisions in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

@client.sf1('P0010001', 'METDIV', 'STATE:06+CBSA:31100')

Retrieve fields from all Metropolitan Division in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

@client.sf1('P0010001', 'METDIV', 'STATE:06+CBSA:31100')

Retrieve fields from a specific Metropolitan Division in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

@client.sf1('P0010001', 'METDIV:31084', 'STATE:06+CBSA:31100')

#### ￼￼￼￼￼￼￼￼340   CSA    state-combined statistical area

Retrieve fields from all Combined Statistical Areas in a specific State:

@client.sf1('P0010001', 'CSA', 'STATE:24')

Retrieve fields from a specific Combined Statistical Area in a specific State:

@client.sf1('P0010001', 'CSA:428', 'STATE:24')

#### ￼￼￼￼￼￼￼￼500   CD   state-congressional district

Retrieve fields from all Congressional Districts in a specific State:

@client.sf1('P0010001', 'CD', 'STATE:24')

Retrieve fields from a specific Congressional District in a specific State:

@client.sf1('P0010001', 'CD:01', 'STATE:24')

#### ￼￼￼￼￼￼￼￼510   state-congressional district-county

Retrieve fields for all Counties within a specific Congressional District:

@client.sf1('P0010001', 'COUNTY', 'STATE:24+CD:01')

Retrieve fields for a specific County within a specific Congressional District:

@client.sf1('P0010001', 'COUNTY:01', 'STATE:24+CD:01')

#### ￼￼￼￼￼￼￼￼511 state-congressional district-county- tract

Retrieve fields for all Tracts within a specific Congressional District, County Remainder:

@client.sf1('P0010001', 'TRACT', 'STATE:24+CD:01+COUNTY:003')

Retrieve fields for a specific County within a specific Congressional District, County Remainder:

@client.sf1('P0010001', 'TRACT:702100', 'STATE:24+CD:01+COUNTY:003')

### ￼￼￼￼￼￼￼￼521   state-congressional district-county-county subdivision

Retrieve fields for all County Subdivisions within a specific Congressional District, County Remainder:

@client.sf1('P0010001', 'COUSUB', 'STATE:24+CD:01+COUNTY:003')

Retrieve fields for a specific County Subdivision within a specific Congressional District, County Remainder:

@client.sf1('P0010001', 'COUSUB:90100', 'STATE:24+CD:01+COUNTY:003')

#### ￼￼￼￼￼￼￼￼531   state congressional district-place

Retrieve fields for all Places within a specific Congressional District:

@client.sf1('P0010001', 'PLACE', 'STATE:24+CD:01')

Retrieve fields for a specific Place within a specific Congressional District, County Remainder:

@client.sf1('P0010001', 'PLACE:00125', 'STATE:24+CD:01')

#### ￼￼￼￼￼￼550   state-￼￼congressional district-american indian area/alaska native area/hawaiian home land

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Lands within a specific Congressional District:

@client.sf1('P0010001', 'AIANNH', 'STATE:02+CD:00')

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land  within a specific Congressional District:

@client.sf1('P0010001', 'AIANNH:03800', 'STATE:02+CD:00')

#### ￼￼￼￼￼￼￼￼560   state-congressional district-alaska native regional corporation

Retrieve fields for all Alaska Native Regional Corporations within a specific Congressional District:

@client.sf1('P0010001', 'AIANNH', 'STATE:02+CD:00')

Retrieve fields for a specific Alaska Native Regional Corporation  within a specific Congressional District:

@client.sf1('P0010001', 'AIANNH:00590', 'STATE:02+CD:00')

### ￼￼￼￼￼￼￼￼610   SLDU   state-state legislative district (upper chamber)

Retrieve fields for all State Legislative Districts (Upper Chamber) within a State:

@client.sf1('P0010001', 'SLDU', 'STATE:02')

Retrieve fields for a specific State Legislative District (Upper Chamber) within a State:

@client.sf1('P0010001', 'SLDU:00A', 'STATE:02')

### ￼￼￼￼￼￼￼￼620   SLDL   state-state legislative district (upper chamber)

Retrieve fields for all State Legislative Districts (Lower Chamber) within a State:

@client.sf1('P0010001', 'SLDL', 'STATE:02')

Retrieve fields for a specific State Legislative District (Upper Chamber) within a State:

@client.sf1('P0010001', 'SLDL:001', 'STATE:02')
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
#### ￼￼￼￼￼￼￼￼871   ZCTA5   state-zip code tabulation area

Retrieve fields for all Zip Code Tabulation Areas within a specific State:

@client.sf1('P0010001', 'ZCTA', 'STATE:02')

Retrieve fields for a specific Zip Code Tabulation Area within a specific State:

@client.sf1('P0010001', 'ZCTA:99501', 'STATE:02')

### ACS5 2010 Examples and Supported Geography

Querying the Census Bureau for ACS5 data is done in the same format as querying for census data.  The only difference is the geographies and fields available.

#### 040   STATE   state

Retrieve fields for all States:

@client.acs5('B00001_001E', 'STATE')

Retrieve fields for California (geoid: 06):

@client.acs5('B00001_001E', 'STATE:06')

Retrieve fields for California and Alaska:

@client.acs5('B00001_001E', 'STATE:06,02')

#### 050   COUNTY   state-county 

Retrieve fields for all Counties:

@client.acs5('B00001_001E', 'COUNTY')

Retrieve fields for Counties in California:

@client.acs5('B00001_001E', 'COUNTY', 'STATE:06')

Retrieve fields for a specific County in California:

@client.acs5('B00001_001E', 'COUNTY:001', 'STATE:06')

#### 060    COUSUB   state-county-county subdivision

Retrieve fields for all County Subdivisions within a specific County:

@client.acs5('B00001_001E', 'COUSUB', 'STATE:02+COUNTY:290')

Retrieve fields for a specific County Subdivision within a specific County:

@client.acs5('B00001_001E', 'COUSUB:86690', 'STATE:02+COUNTY:290')

Note: You must also specify the State the County belongs to.

#### 067   SUBMCD   state-county-county subdivision-subminor civil subdivision

Retrieve fields for all Subminor Civil Subdivisions within a specific County Subdivision:

@client.acs5('B00001_001E', 'SUBMCD', 'STATE:72+COUNTY:127+COUSUB:79693')

Retrieve fields for a specific Subminor Civil Subdivision within a specific County Subdivision:

@client.acs5('B00001_001E', 'SUBMCD:02350', 'STATE:72+COUNTY:127+COUSUB:79693')

#### 070   PLACE   state-county-county subdivision-place

Retrieve fields for all Places within a specific County Subdivision:

@client.acs5('B00001_001E', 'PLACE', 'STATE:02+COUNTY:290+COUSUB:86690')

Retrieve fields for a specific Place within a specific County Subdivision:

@client.acs5('B00001_001E', 'PLACE:05750', 'STATE:02+COUNTY:290+COUSUB:86690')

#### 080   TRACT   state-county-county subdivision-place-tract

Retrieve fields for all Tracts within a specific Place:

@client.acs5('B00001_001E', 'TRACT', 'STATE:02+COUNTY:290+COUSUB:86690+PLACE:05750')

Retrieve fields for a specific Tract within a specific Place:

@client.acs5('B00001_001E', 'TRACT:000100', 'STATE:02+COUNTY:290+COUSUB:86690+PLACE:05750')

#### 140   TRACT   state-county-tract

Retrieve fields for all Tracts within a specific County:

@client.acs5('B00001_001E', 'TRACT', 'STATE:02+COUNTY:170')

Retrieve fields for a specific Tract within a specific County:

@client.acs5('B00001_001E', 'TRACT:000101', 'STATE:02+COUNTY:170')

#### 150   BG   ￼￼￼￼￼￼￼￼￼state-county- tract-block group

Retrieve fields for all Block Groups within a specific Tract:

@client.acs5('B00001_001E', 'BG', 'STATE:02+COUNTY:170+TRACT:000101')

Retrieve fields for a specific Block Group within a specific Tract:

@client.acs5('B00001_001E', 'BG:1', 'STATE:02+COUNTY:170+TRACT:000101')

#### 160   PLACE   state-place

Retrieve fields for all Places:

@client.acs5('B00001_001E', 'PLACE')

Retrieve fields for all Places within a specific State:

@client.acs5('B00001_001E', 'PLACE', 'STATE:06')

Retrieve fields for a specific place within a specific State:

@client.acs5('B00001_001E', 'PLACE:00135', 'STATE:06')

#### ￼￼￼￼￼￼￼￼280   AIANNH   state-american indian area/alaska native area/hawaiian home land

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land:

@client.acs5('B00001_001E', 'AIANNH')

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

@client.acs5('B00001_001E', 'AIANNH', 'STATE:02')

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

@client.acs5('B00001_001E', 'AIANNH:03800', 'STATE:02')

#### ￼￼￼￼￼￼￼￼500   CD   state-congressional district

Retrieve fields from all Congressional Districts in a specific State:

@client.acs5('B00001_001E', 'CD', 'STATE:24')

Retrieve fields from a specific Congressional District in a specific State:

@client.acs5('B00001_001E', 'CD:01', 'STATE:24')

## Additional Resources

For a list of all the fields available for the 2010 Census, please consult the following PDF:

2010 Census Summary File 1 - Census Bureau
http://www.census.gov/prod/cen2010/doc/sf1.pdf

For a list of all the fields available for the 2006-2010 ACS5, please consult the following PDF:

The 2006-2010 ACS 5-Year Summary File - Census Bureau
http://www2.census.gov/acs2010_5yr/summaryfile/ACS_2006-2010_SF_Tech_Doc.pdf
