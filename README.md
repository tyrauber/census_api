# Census API

This gem provides a Ruby wrapper around the Census Bureau API.


## Obtaining an API key

To be able to use this gem, you'll need a Census Bureau API key. To request an API key, visit
[http://www.census.gov/developers/tos/key_request.html][key] and follow the instructions.

[key]: (http://www.census.gov/developers/tos/key_request.html)


## Installing the gem

To use this gem, install it with <tt>gem install census_api</tt> or add it to your Gemfile:

`gem 'census_api'`

And install it with <tt>bundle install</tt>

## Usage / Retrieving Census Data

### (Optional) Set the API key as an environment variable

Once you have the API key, you may want to store it as an environment variable.

```sh
$ export $CENSUS_API_KEY='your-api-key'
```

### Register a New Client

```ruby
@client = CensusApi::Client.new(API_KEY) 
@client = CensusApi::Client.new(ENV['CENSUS_API_KEY']) # from the environment variable
@client = CensusApi::Client.new(API_KEY, dataset: 'SF1') # with a dataset
@client = CensusApi::Client.new(API_KEY, {vintage: 2012, dataset: 'SF1'}) # specific vintage (year) data; defaults to 2010
```

### Query a Dataset

To query the 2010 Census SF1 dataset, first set the dataset to 'SF1':

```ruby
@client = CensusApi::Client.new(API_KEY, dataset: 'SF1') # with a dataset # during intialization
@client.dataset = 'SF1' # or after initialization, setting the instance variable
```

To query the 2006-2010 ACS5 dataset, set the dataset to 'ACS5':

```ruby
@client = CensusApi::Client.new(API_KEY, dataset: 'ACS5') # with a dataset # during intialization
@client.dataset = 'ACS5' # or after initialization, setting the instance variable
```

Then, use `Client#where` with an options hash to query for Census data. The fields and level parameters are required. The within parameter is optional and scopes the query. For example:

```ruby
@client.where({ fields: 'P0010001', level: 'COUNTY:001', within: 'STATE:06' })

```

The `Client.find` method which takes positional arguments is still available, but deprecated.

```ruby
@client.find('P0010001', 'COUNTY:001', 'STATE:06')

```

For a list of the fields available for each dataset, review the reference PDFs linked at the bottom of this document.

#### Parameters

The 'fields' parameter is a comma separated string of SF1 field names.

The 'level' parameter is a single geography type, and optionally, the geography ids (geoid) for specific geographies of that type. A colon separates the geography type from the id and a comma separates ids.

For example, 'STATE:06,02' would reference the state of California and Alaska.

The 'within' parameter is a set of geography types or geography. Similar to the 'level' parameter, a colon separates the geography type from the id and a comma separates ids. Sets of geography are separated by a plus symbol.

For example, 'STATE:02+COUNTY:290' would reference the 'Yukon-Koyukuk Census Area' County in the state of Alaska.

The 'within' parameter is optional, or required, depending upon the geography type. The smaller the geography type being required, the more the request must be restricted by the 'within' parameter.

## Census 2010 SF1 Examples and Supported Geography

#### STATE - *(040) state*

Retrieve fields for all States:

`@client.where({ fields: 'P0010001', level: 'STATE' })`

Retrieve fields for California (geoid: 06):

`@client.where({ fields: 'P0010001', level: 'STATE:06' })`

Retrieve fields for California and Alaska:

`@client.where({ fields: 'P0010001', level: 'STATE:06,02' })`

#### COUNTY - *(050) state-county*

Retrieve fields for all Counties:

`@client.where({ fields: 'P0010001', level: 'COUNTY' })`

Retrieve fields for Counties in California:

`@client.where({ fields: 'P0010001', level: 'COUNTY', within: 'STATE:06' })`

Retrieve fields for a specific County in California:

`@client.where({ fields: 'P0010001', level: 'COUNTY:001', within: 'STATE:06' })`

#### COUSUB - *(060) state-county-county subdivision*

Retrieve fields for all County Subdivisions within a specific County:

`@client.where({ fields: 'P0010001', level: 'COUSUB', within: 'STATE:02+COUNTY:290' })`

Retrieve fields for a specific County Subdivision within a specific County:

`@client.where({ fields: 'P0010001', level: 'COUSUB:86690', within: 'STATE:02+COUNTY:290' })`

Note: You must also specify the State the County belongs to.

#### SUBMCD - *(067) state-county-county subdivision-subminor civil subdivision*

Retrieve fields for all Subminor Civil Subdivisions within a specific County Subdivision:

`@client.where({ fields: 'P0010001', level: 'SUBMCD', within: 'STATE:72+COUNTY:127+COUSUB:79693' })`

Retrieve fields for a specific Subminor Civil Subdivisions within a specific County Subdivision:

`@client.where({ fields: 'P0010001', level: 'SUBMCD:02350', within: 'STATE:72+COUNTY:127+COUSUB:79693' })`

#### TABBLOCK - *(101) state-county-tract-block*

Retrieve fields for all Blocks within a specific Tract

`@client.where({ fields: 'P0010001', level: 'TABBLOCK', within: 'STATE:02+COUNTY:290+TRACT:00100' })`

Retrieve fields for a specific Subminor Civil Subdivisions within a specific County Subdivision:

`@client.where({ fields: 'P0010001', level: 'SUBMCD:02350', within: 'STATE:72+COUNTY:127+COUSUB:79693' })`

#### TRACT - *(140) state-county-tract*

Retrieve fields for all Tracts within a specific County:

`@client.where({ fields: 'P0010001', level: 'TRACT', within: 'STATE:02+COUNTY:170' })`

Retrieve fields for a specific Tract within a specific County:

`@client.where({ fields: 'P0010001', level: 'TRACT:000101', within: 'STATE:02+COUNTY:170' })`

#### BG - *(150) state-county- tract-block group*

Retrieve fields for all Block Groups within a specific Tract:

`@client.where({ fields: 'P0010001', level: 'BG', within: 'STATE:02+COUNTY:170+TRACT:000101' })`

Retrieve fields for a specific Block Group within a specific Tract:

`@client.where({ fields: 'P0010001', level: 'BG:1', within: 'STATE:02+COUNTY:170+TRACT:000101' })`

#### PLACE -*(160) state-place*

Retrieve fields for all Places:

`@client.where({ fields: 'P0010001', level: 'PLACE' })`

Retrieve fields for all Places within a specific State:

`@client.where({ fields: 'P0010001', level: 'PLACE', within: 'STATE:06' })`

Retrieve fields for a specific place within a specific State:

`@client.where({ fields: 'P0010001', level: 'PLACE:00135', within: 'STATE:06' })`

#### ANRC - *(260) state-alaska native regional corporation*

Retrieve fields for all Alaska Native Regional Corporations:

`@client.where({ fields: 'P0010001', level: 'ANRC' })`

Retrieve fields for all Alaska Native Regional Corporations within a specific State:

`@client.where({ fields: 'P0010001', level: 'ANRC', within: 'STATE:02' })`

Retrieve fields for all Alaska Native Regional Corporations within a specific State:

`@client.where({ fields: 'P0010001', level: 'ANRC:00590', within: 'STATE:02' })`

#### AIANNH - *(280) state-american indian area/alaska native area/hawaiian home land*

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land:

`@client.where({ fields: 'P0010001', level: 'AIANNH' })`

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

`@client.where({ fields: 'P0010001', level: 'AIANNH', within: 'STATE:02 }')`

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

`@client.where({ fields: 'P0010001', level: 'AIANNH:03800', within: 'STATE:02' })`

#### AITS - *(281) state-american indian area-tribal subdivision*

Retrieve fields for all American Indian Area-Tribal Subdivisions:

__DOES NOT WORK__: `@client.where({ fields: 'P0010001', level: 'AITS' })`

Retrieve fields for all American Indian Area-Tribal Subdivisions in a specific American Indian Area:

`@client.where({ fields: 'P0010001', level: 'AITS', within: 'STATE:40+AIANNH:13735' })`

Retrieve fields for a specific American Indian Area-Tribal Subdivision in a specific American Indian Area:

`@client.where({ fields: 'P0010001', level: 'AITS:83127', within: 'STATE:40+AIANNH:13735' })`

#### CBSA - *(320) state-metropolitan statistical area/micropolitan statistical area*

Retrieve fields from all Metropolitan Statistical Areas / Micropolitan Statistical Areas in a specific State:

`@client.where({ fields: 'P0010001', level: 'CBSA', within: 'STATE:02' })`

Retrieve fields from a specific Metropolitan Statistical Areas / Micropolitan Statistical Areas in a specific State:

`@client.where({ fields: 'P0010001', level: 'CBSA:11260', within: 'STATE:02' })`

#### METDIV - *(323)  state-metropolitan statistical area/micropolitan statistical area- metropolitan division*

Retrieve fields from all Metropolitan Divisions in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

`@client.where({ fields: 'P0010001', level: 'METDIV', within: 'STATE:06+CBSA:31100' })`

Retrieve fields from all Metropolitan Division in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

`@client.where({ fields: 'P0010001', level: 'METDIV', within: 'STATE:06+CBSA:31100' })`

Retrieve fields from a specific Metropolitan Division in a specific Metropolitan Statistical Area / Micropolitan Statistical Area:

`@client.where({ fields: 'P0010001', level: 'METDIV:31084', within: 'STATE:06+CBSA:31100' })`

#### CSA - *(340) - state-combined statistical area*

Retrieve fields from all Combined Statistical Areas in a specific State:

`@client.where({ fields: 'P0010001', level: 'CSA', within: 'STATE:24' })`

Retrieve fields from a specific Combined Statistical Area in a specific State:

`@client.where({ fields: 'P0010001', level: 'CSA:428', within: 'STATE:24' })`

#### CD - *(500) state-congressional district*

Retrieve fields from all Congressional Districts in a specific State:

`@client.where({ fields: 'P0010001', level: 'CD', within: 'STATE:24' })`

Retrieve fields from a specific Congressional District in a specific State:

`@client.where({ fields: 'P0010001', level: 'CD:01', within: 'STATE:24' })`

#### COUNTY (Remainder) - *(510) state-congressional district-county*

Retrieve fields for all Counties within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'COUNTY', within: 'STATE:24+CD:01' })`

Retrieve fields for a specific County within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'COUNTY:003', within: 'STATE:24+CD:01' })`

#### TRACT (Remainder) - *(511) state-congressional district-county-tract*

Retrieve fields for all Tracts within a specific Congressional District, County Remainder:

`@client.where({ fields: 'P0010001', level: 'TRACT', within: 'STATE:24+CD:01+COUNTY:003' })`

Retrieve fields for a specific County within a specific Congressional District, County Remainder:

`@client.where({ fields: 'P0010001', level: 'TRACT:702100', within: 'STATE:24+CD:01+COUNTY:003' })`

### COUSUB (Remainder) - *(521) state-congressional district-county-county subdivision*

Retrieve fields for all County Subdivisions within a specific Congressional District, County Remainder:

`@client.where({ fields: 'P0010001', level: 'COUSUB', within: 'STATE:24+CD:01+COUNTY:003' })`

Retrieve fields for a specific County Subdivision within a specific Congressional District, County Remainder:

`@client.where({ fields: 'P0010001', level: 'COUSUB:90100', within: 'STATE:24+CD:01+COUNTY:003' })`

#### PLACE (Remainder) - *(531) state congressional district-place*

Retrieve fields for all Places within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'PLACE', within: 'STATE:24+CD:01' })`

Retrieve fields for a specific Place within a specific Congressional District, County Remainder:

`@client.where({ fields: 'P0010001', level: 'PLACE:00125', within: 'STATE:24+CD:01' })`

#### AIANNH (Remainder) - *550) state-￼￼congressional district-american indian area/alaska native area/hawaiian home land*

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Lands within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'AIANNH', within: 'STATE:02+CD:00' })`

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land  within a specific Congressional District:

__DOES NOT WORK__: `@client.where({ fields: 'P0010001', level: 'AIANNH:0010', within: 'STATE:02+CD:00' })`

#### ANRC (Remainder) - *(560) state-congressional district-alaska native regional corporation*

Retrieve fields for all Alaska Native Regional Corporations within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'AIANNH', within: 'STATE:02+CD:00' })`

Retrieve fields for a specific Alaska Native Regional Corporation  within a specific Congressional District:

`@client.where({ fields: 'P0010001', level: 'AIANNH:00590', within: 'STATE:02+CD:00' })`

#### SLDU - *(610￼) state-state legislative district (upper chamber)*

Retrieve fields for all State Legislative Districts (Upper Chamber) within a State:

`@client.where({ fields: 'P0010001', level: 'SLDU', within: 'STATE:02' })`

Retrieve fields for a specific State Legislative District (Upper Chamber) within a State:

`@client.where({ fields: 'P0010001', level: 'SLDU:00A', within: 'STATE:02' })`

#### SLDU - *(620) state-state legislative district (lower chamber)*

Retrieve fields for all State Legislative Districts (Lower Chamber) within a State:

`@client.where({ fields: 'P0010001', level: 'SLDL', within: 'STATE:02' })`

Retrieve fields for a specific State Legislative District (Lower Chamber) within a State:

`@client.where({ fields: 'P0010001', level: 'SLDL:001', within: 'STATE:02' })`
￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼￼
#### ZCTA5 - *(871) state-zip code tabulation area*

Retrieve fields for all Zip Code Tabulation Areas within a specific State:

`@client.where({ fields: 'P0010001', level: 'ZCTA5', within: 'STATE:02' })`

Retrieve fields for a specific Zip Code Tabulation Area within a specific State:

`@client.where({ fields: 'P0010001', level: 'ZCTA5:99501', within: 'STATE:02' })`

## ACS5 2010 Examples and Supported Geography

Querying the Census Bureau for ACS5 data is done in the same format as querying for census data.  The only difference is the geographies and fields available.

#### STATE - *(040) state *

Retrieve fields for all States:

`@client.where({ fields: 'B00001_001E', level: 'STATE' })`

Retrieve fields for California (geoid: 06):

`@client.where({ fields: 'B00001_001E', level: 'STATE:06' })`

Retrieve fields for California and Alaska:

`@client.where({ fields: 'B00001_001E', level: 'STATE:06,02' })`

#### COUNTY - *(050) state-county*

Retrieve fields for all Counties:

`@client.where({ fields: 'B00001_001E', level: 'COUNTY' })`

Retrieve fields for Counties in California:

`@client.where({ fields: 'B00001_001E', level: 'COUNTY', within: 'STATE:06' })`

Retrieve fields for a specific County in California:

`@client.where({ fields: 'B00001_001E', level: 'COUNTY:001', within: 'STATE:06' })`

#### COUSUB - *(060) state-county-county subdivision*

Retrieve fields for all County Subdivisions within a specific County:

`@client.where({ fields: 'B00001_001E', level: 'COUSUB', within: 'STATE:02+COUNTY:290' })`

Retrieve fields for a specific County Subdivision within a specific County:

`@client.where({ fields: 'B00001_001E', level: 'COUSUB:86690', within: 'STATE:02+COUNTY:290' })`

Note: You must also specify the State the County belongs to.

#### SUBMCD - *(067) state-county-county subdivision-subminor civil subdivision*

Retrieve fields for all Subminor Civil Subdivisions within a specific County Subdivision:

`@client.where({ fields: 'B00001_001E', level: 'SUBMCD', within: 'STATE:72+COUNTY:127+COUSUB:79693' })`

Retrieve fields for a specific Subminor Civil Subdivision within a specific County Subdivision:

`@client.where({ fields: 'B00001_001E', level: 'SUBMCD:02350', within: 'STATE:72+COUNTY:127+COUSUB:79693' })`

#### PLACE - *(070) state-county-county subdivision-place*

Retrieve fields for all Places within a specific County Subdivision:

`@client.where({ fields: 'B00001_001E', level: 'PLACE', within: 'STATE:02+COUNTY:290+COUSUB:86690' })`

Retrieve fields for a specific Place within a specific County Subdivision:

`@client.where({ fields: 'B00001_001E', level: 'PLACE:05750', within: 'STATE:02+COUNTY:290+COUSUB:86690' })`

#### TRACT - *(080) state-county-county subdivision-place-tract*

Retrieve fields for all Tracts within a specific Place:

`@client.where({ fields: 'B00001_001E', level: 'TRACT', within: 'STATE:02+COUNTY:290+COUSUB:86690+PLACE:05750' })`

Retrieve fields for a specific Tract within a specific Place:

`@client.where({ fields: 'B00001_001E', level: 'TRACT:000100', within: 'STATE:02+COUNTY:290+COUSUB:86690+PLACE:05750' })`

#### TRACT - *(140) state-county-tract*

Retrieve fields for all Tracts within a specific County:

`@client.where({ fields: 'B00001_001E', level: 'TRACT', within: 'STATE:02+COUNTY:170' })`

Retrieve fields for a specific Tract within a specific County:

`@client.where({ fields: 'B00001_001E', level: 'TRACT:000101', within: 'STATE:02+COUNTY:170' })`

#### BG - *(150) ￼￼￼￼￼￼￼￼￼state-county- tract-block group*

Retrieve fields for all Block Groups within a specific Tract:

`@client.where({ fields: 'B00001_001E', level: 'BG', within: 'STATE:02+COUNTY:170+TRACT:000101' })`

Retrieve fields for a specific Block Group within a specific Tract:

`@client.where({ fields: 'B00001_001E', level: 'BG:1', within: 'STATE:02+COUNTY:170+TRACT:000101' })`

#### PLACE - *(160) state-place*

Retrieve fields for all Places:

`@client.where({ fields: 'B00001_001E', level: 'PLACE' })`

Retrieve fields for all Places within a specific State:

`@client.where({ fields: 'B00001_001E', level: 'PLACE', within: 'STATE:06' })`

Retrieve fields for a specific place within a specific State:

`@client.where({ fields: 'B00001_001E', level: 'PLACE:00135', within: 'STATE:06' })`

#### AIANNH - *(280) state-american indian area/alaska native area/hawaiian home land*

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land:

`@client.where({ fields: 'B00001_001E', level: 'AIANNH' })`

Retrieve fields for all American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

`@client.where({ fields: 'B00001_001E', level: 'AIANNH', within: 'STATE:02' })`

Retrieve fields for a specific American Indian Area/Alaska Native Area/Hawaiian Home Land within a specific State:

__DOES NOT WORK__: `@client.where({ fields: 'B00001_001E', level: 'AIANNH:03800', within: 'STATE:02' })`

#### CD - *(500) state-congressional district*

Retrieve fields from all Congressional Districts in a specific State:

`@client.where({ fields: 'B00001_001E', level: 'CD', within: 'STATE:24' })`

Retrieve fields from a specific Congressional District in a specific State:

`@client.where({ fields: 'B00001_001E', level: 'CD:01', within: 'STATE:24' })`

## Additional Resources

For a list of all the fields available for the 2010 Census, please consult the following PDF:

2010 Census Summary File 1 - Census Bureau

http://www.census.gov/prod/cen2010/doc/sf1.pdf

For a list of all the fields available for the 2006-2010 ACS5, please consult the following PDF:

The 2006-2010 ACS 5-Year Summary File - Census Bureau

http://www2.census.gov/acs2010_5yr/summaryfile/ACS_2006-2010_SF_Tech_Doc.pdf
