module Census2012AcsAcs1
  EXAMPLES = [
    ["B00001_001E", "US:*"],
    ["B00001_001E", "US:1"],
    ["B00001_001E", "REGION:*"],
    ["B00001_001E", "REGION:1"],
    ["B00001_001E", "DIVISION:*"],
    ["B00001_001E", "DIVISION:1"],
    ["B00001_001E", "STATE:*"],
    ["B00001_001E", "STATE:01"],
    ["B00001_001E", "COUNTY:*", ["STATE:*"]],
    ["B00001_001E", "COUNTY:*", ["STATE:02"]],
    ["B00001_001E", "COUNTY:020", ["STATE:02"]],
    ["B00001_001E", "COUSUB:*", ["STATE:36", "COUNTY:029"]],
    ["B00001_001E", "COUSUB:02000", ["STATE:36", "COUNTY:029"]],
    ["B00001_001E", "PLACE:*", ["STATE:*"]],
    ["B00001_001E", "PLACE:*", ["STATE:01"]],
    ["B00001_001E", "PLACE:07000", ["STATE:01"]],
    ["B00001_001E", "ANRC:*", ["STATE:*"]],
    ["B00001_001E", "ANRC:*", ["STATE:02"]],
    ["B00001_001E", "ANRC:67940", ["STATE:02"]],
    ["B00001_001E", "AIANNH:*"],
    ["B00001_001E", "AIANNH:2430"],
    ["B00001_001E", "CBSA:*"],
    ["B00001_001E", "CBSA:10420"],
    ["B00001_001E", "CSA:*"],
    ["B00001_001E", "CSA:104"],
    ["B00001_001E", "NECTA:*"],
    ["B00001_001E", "NECTA:71650"],
    ["B00001_001E", "UAC:*"],
    ["B00001_001E", "UAC:27253"],
    ["B00001_001E", "CD:*", ["STATE:*"]],
    ["B00001_001E", "CD:*", ["STATE:01"]],
    ["B00001_001E", "CD:01", ["STATE:01"]],
    ["B00001_001E", "ELSD:*", ["STATE:*"]],
    ["B00001_001E", "ELSD:*", ["STATE:04"]],
    ["B00001_001E", "ELSD:00600", ["STATE:04"]],
    ["B00001_001E", "SCSD:*", ["STATE:*"]],
    ["B00001_001E", "SCSD:*", ["STATE:04"]],
    ["B00001_001E", "SCSD:00450", ["STATE:04"]],
    ["B00001_001E", "UNSD:*", ["STATE:*"]],
    ["B00001_001E", "UNSD:*", ["STATE:01"]],
    ["B00001_001E", "UNSD:00007", ["STATE:01"]],
    ["B00001_001E", "public%20use%20microdata%20area:*", ["STATE:*"]],
    ["B00001_001E", "public%20use%20microdata%20area:*", ["STATE:04"]],
    ["B00001_001E", "public%20use%20microdata%20area:00202", ["STATE:04"]],
    ["B00001_001E", "METDIV:*", ["CBSA:*"]],
    ["B00001_001E", "METDIV:*", ["CBSA:31100"]],
    ["B00001_001E", "METDIV:31084", ["CBSA:31100"]],
    ["B00001_001E", "CNECTA:*"],
    ["B00001_001E", "CNECTA:715"],
    ["B00001_001E", "principal%20city%20(or%20part):*", ["CBSA:*"]],
    ["B00001_001E", "principal%20city%20(or%20part):*", ["CBSA:10740"]],
    ["B00001_001E", "principal%20city%20(or%20part):02000", ["CBSA:10740"]],
    ["B00001_001E", "PCITY:*", ["NECTA:*"]],
    ["B00001_001E", "PCITY:*", ["NECTA:71950"]],
    ["B00001_001E", "PCITY:73000", ["NECTA:71950"]],
    ["B00001_001E", "NECTADIV:*", ["NECTA:71650"]],
    ["B00001_001E", "NECTADIV:71654", ["NECTA:71650"]]
  ]
end
