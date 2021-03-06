module Census2015AcsAcs5
  EXAMPLES = [
    ["NAME", "US:*"],
    ["NAME", "US:1"],
    ["NAME", "REGION:*"],
    ["NAME", "REGION:1"],
    ["NAME", "DIVISION:*"],
    ["NAME", "DIVISION:1"],
    ["NAME", "STATE:*"],
    ["NAME", "STATE:01"],
    ["NAME", "COUNTY:*", ["STATE:*"]],
    ["NAME", "COUNTY:*", ["STATE:02"]],
    ["NAME", "COUNTY:013", ["STATE:02"]],
    ["NAME", "COUSUB:*", ["STATE:36", "COUNTY:*"]],
    ["NAME", "COUSUB:*", ["STATE:36", "COUNTY:029"]],
    ["NAME", "COUSUB:01099", ["STATE:36", "COUNTY:029"]],
    ["NAME", "TRACT:*", ["STATE:01", "COUNTY:*"]],
    ["NAME", "TRACT:*", ["STATE:01", "COUNTY:073"]],
    ["NAME", "TRACT:000100", ["STATE:01", "COUNTY:073"]],
    ["NAME", "PLACE:*", ["STATE:*"]],
    ["NAME", "PLACE:*", ["STATE:02"]],
    ["NAME", "PLACE:00065", ["STATE:02"]],
    ["NAME", "ANRC:*", ["STATE:*"]],
    ["NAME", "ANRC:*", ["STATE:02"]],
    ["NAME", "ANRC:41640", ["STATE:02"]],
    ["NAME", "AIANNH:*"],
    ["NAME", "AIANNH:0010"],
    ["NAME", "CBSA:*"],
    ["NAME", "CBSA:10100"],
    ["NAME", "CSA:*"],
    ["NAME", "CSA:104"],
    ["NAME", "NECTA:*"],
    ["NAME", "NECTA:70450"],
    ["NAME", "UAC:*"],
    ["NAME", "UAC:00037"],
    ["NAME", "CD:*", ["STATE:*"]],
    ["NAME", "CD:*", ["STATE:56"]],
    ["NAME", "CD:00", ["STATE:56"]],
    ["NAME", "ELSD:*", ["STATE:50"]],
    ["NAME", "ELSD:00001", ["STATE:50"]],
    ["NAME", "SCSD:*", ["STATE:50"]],
    ["NAME", "SCSD:00002", ["STATE:50"]],
    ["NAME", "UNSD:*", ["STATE:01"]],
    ["NAME", "UNSD:00001", ["STATE:01"]],
    ["NAME", "COUNTY:*", ["STATE:01", "PLACE:62328"]],
    ["NAME", "COUNTY:001", ["STATE:01", "PLACE:62328"]],
    ["NAME", "place%20remainder:*", ["STATE:01", "COUNTY:001", "COUSUB:92106"]],
    ["NAME", "place%20remainder:60264", ["STATE:01", "COUNTY:001", "COUSUB:92106"]],
    ["NAME", "BG:*", ["STATE:06", "COUNTY:061", "TRACT:*"]],
    ["NAME", "BG:*", ["STATE:06", "COUNTY:061", "TRACT:990000"]],
    ["NAME", "BG:0", ["STATE:06", "COUNTY:061", "TRACT:990000"]],
    ["NAME", "public%20use%20microdata%20area:*", ["STATE:*"]],
    ["NAME", "public%20use%20microdata%20area:*", ["STATE:36"]],
    ["NAME", "public%20use%20microdata%20area:00100", ["STATE:36"]],
    ["NAME", "ZCTA5:*"],
    ["NAME", "ZCTA5:00610"],
    ["NAME", "SLDU:*", ["STATE:12"]],
    ["NAME", "SLDU:001", ["STATE:12"]],
    ["NAME", "SLDL:*", ["STATE:01"]],
    ["NAME", "SLDL:001", ["STATE:01"]],
    ["NAME", "PCITY:*", ["CBSA:11500", "STATE:01"]],
    ["NAME", "PCITY:57576", ["CBSA:11500", "STATE:01"]],
    ["NAME", "METDIV:*", ["CBSA:14460"]],
    ["NAME", "METDIV:40484", ["CBSA:14460"]],
    ["NAME", "CBSA:*", ["STATE:46"]],
    ["NAME", "CBSA:10100", ["STATE:46"]],
    ["NAME", "principal%20city%20(or%20part):*", ["STATE:01", "CBSA:11500"]],
    ["NAME", "principal%20city%20(or%20part):57576", ["STATE:01", "CBSA:11500"]],
    ["NAME", "STATE:*", ["CBSA:10700"]],
    ["NAME", "STATE:01", ["CBSA:10700"]],
    ["NAME", "AIANNH:*", ["STATE:01"]],
    ["NAME", "AIANNH:9820", ["STATE:01"]],
    ["NAME", "CNECTA:*"],
    ["NAME", "CNECTA:775"],
    ["NAME", "CSA:*", ["STATE:41"]],
    ["NAME", "CSA:140", ["STATE:41"]],
    ["NAME", "CNECTA:*", ["STATE:09"]],
    ["NAME", "CNECTA:715", ["STATE:09"]],
    ["NAME", "NECTA:*", ["STATE:09"]],
    ["NAME", "NECTA:76450", ["STATE:09"]],
    ["NAME", "STATE:*", ["urban%20growth%20area:02791"]],
    ["NAME", "STATE:01", ["urban%20growth%20area:02791"]],
    ["NAME", "COUNTY:*", ["urban%20growth%20area:68482", "STATE:01"]],
    ["NAME", "COUNTY:003", ["urban%20growth%20area:68482", "STATE:01"]],
    ["NAME", "COUNTY:*", ["STATE:01", "SLDU:030"]],
    ["NAME", "COUNTY:001", ["STATE:01", "SLDU:030"]],
    ["NAME", "COUNTY:*", ["STATE:01", "SLDL:096"]],
    ["NAME", "COUNTY:003", ["STATE:01", "SLDL:096"]],
    ["NAME", "STATE:*", ["NECTA:71950"]],
    ["NAME", "STATE:09", ["NECTA:71950"]],
    ["NAME", "principal%20city%20(or%20part):*", ["NECTA:70450", "STATE:*"]],
    ["NAME", "principal%20city%20(or%20part):*", ["NECTA:70450", "STATE:25"]],
    ["NAME", "principal%20city%20(or%20part):02515", ["NECTA:70450", "STATE:25"]],
    ["NAME", "county%20(or%20part):*", ["NECTA:70450", "STATE:*"]],
    ["NAME", "county%20(or%20part):*", ["NECTA:70450", "STATE:25"]],
    ["NAME", "county%20(or%20part):011", ["NECTA:70450", "STATE:25"]],
    ["NAME", "county%20subdivision%20(or%20part):*", ["NECTA:70450", "STATE:25", "COUNTY:*"]],
    ["NAME", "county%20subdivision%20(or%20part):*", ["NECTA:70450", "STATE:25", "COUNTY:011"]],
    ["NAME", "county%20subdivision%20(or%20part):51265", ["NECTA:70450", "STATE:25", "COUNTY:011"]],
    ["NAME", "NECTADIV:*", ["NECTA:71650"]],
    ["NAME", "NECTADIV:74204", ["NECTA:71650"]],
    ["NAME", "STATE:*", ["NECTA:71650", "NECTADIV:71654"]],
    ["NAME", "STATE:25", ["NECTA:71650", "NECTADIV:71654"]],
    ["NAME", "county%20(or%20part):*", ["NECTA:71650", "NECTADIV:71654", "STATE:25"]],
    ["NAME", "county%20(or%20part):005", ["NECTA:71650", "NECTADIV:71654", "STATE:25"]],
    ["NAME", "county%20subdivision%20(or%20part):*", ["NECTA:71650", "NECTADIV:71654", "STATE:25", "COUNTY:005"]],
    ["NAME", "county%20subdivision%20(or%20part):38225", ["NECTA:71650", "NECTADIV:71654", "STATE:25", "COUNTY:005"]],
    ["NAME", "PCITY:*", ["STATE:09", "NECTA:71950"]],
    ["NAME", "PCITY:74260", ["STATE:09", "NECTA:71950"]],
    ["NAME", "COUNTY:*", ["STATE:09", "NECTA:71950"]],
    ["NAME", "COUNTY:001", ["STATE:09", "NECTA:71950"]],
    ["NAME", "COUSUB:*", ["STATE:09", "NECTA:71950", "COUNTY:001"]],
    ["NAME", "COUSUB:33620", ["STATE:09", "NECTA:71950", "COUNTY:001"]],
    ["NAME", "NECTADIV:*", ["STATE:25", "NECTA:71650"]],
    ["NAME", "NECTADIV:74204", ["STATE:25", "NECTA:71650"]],
    ["NAME", "COUNTY:*", ["STATE:25", "NECTA:71650", "NECTADIV:73604"]],
    ["NAME", "COUNTY:009", ["STATE:25", "NECTA:71650", "NECTADIV:73604"]],
    ["NAME", "COUSUB:*", ["STATE:25", "NECTA:71650", "NECTADIV:71654", "COUNTY:009"]],
    ["NAME", "COUSUB:07420", ["STATE:25", "NECTA:71650", "NECTADIV:71654", "COUNTY:009"]],
    ["NAME", "COUNTY:*", ["STATE:01", "CD:06"]],
    ["NAME", "COUNTY:007", ["STATE:01", "CD:06"]],
    ["NAME", "AIANNH:*", ["STATE:01", "CD:02"]],
    ["NAME", "AIANNH:2865", ["STATE:01", "CD:02"]],
    ["NAME", "county%20(or%20part):*", ["CBSA:10100", "STATE:46"]],
    ["NAME", "county%20(or%20part):013", ["CBSA:10100", "STATE:46"]],
    ["NAME", "STATE:*", ["CBSA:31080", "METDIV:31084"]],
    ["NAME", "STATE:06", ["CBSA:31080", "METDIV:31084"]],
    ["NAME", "county%20(or%20part):*", ["CBSA:14460", "METDIV:14454", "STATE:25"]],
    ["NAME", "county%20(or%20part):021", ["CBSA:14460", "METDIV:14454", "STATE:25"]],
    ["NAME", "COUNTY:*", ["STATE:01", "CBSA:13820"]],
    ["NAME", "COUNTY:009", ["STATE:01", "CBSA:13820"]],
    ["NAME", "METDIV:*", ["STATE:06", "CBSA:41860"]],
    ["NAME", "METDIV:42034", ["STATE:06", "CBSA:41860"]],
    ["NAME", "COUNTY:*", ["STATE:06", "CBSA:41860", "METDIV:36084"]],
    ["NAME", "COUNTY:001", ["STATE:06", "CBSA:41860", "METDIV:36084"]],
    ["NAME", "STATE:*", ["CSA:308"]],
    ["NAME", "STATE:05", ["CSA:308"]],
    ["NAME", "CBSA:*", ["CSA:364"]],
    ["NAME", "CBSA:41900", ["CSA:364"]],
    ["NAME", "STATE:*", ["CSA:142", "CBSA:45180"]],
    ["NAME", "STATE:01", ["CSA:142", "CBSA:45180"]],
    ["NAME", "STATE:*", ["CNECTA:715"]],
    ["NAME", "STATE:09", ["CNECTA:715"]],
    ["NAME", "NECTA:*", ["CNECTA:710"]],
    ["NAME", "NECTA:78850", ["CNECTA:710"]],
    ["NAME", "STATE:*", ["CNECTA:720", "NECTA:78700"]],
    ["NAME", "STATE:09", ["CNECTA:720", "NECTA:78700"]],
    ["NAME", "metropolitan%20statistical%20area/micropolitan%20statistical%20area%20(or%20part):*", ["STATE:01", "CSA:142"]],
    ["NAME", "metropolitan%20statistical%20area/micropolitan%20statistical%20area%20(or%20part):45180", ["STATE:01", "CSA:142"]],
    ["NAME", "NECTA:*", ["STATE:09", "CNECTA:720"]],
    ["NAME", "NECTA:78700", ["STATE:09", "CNECTA:720"]],
    ["NAME", "CONCITY:*", ["STATE:*"]],
    ["NAME", "CONCITY:*", ["STATE:09"]],
    ["NAME", "CONCITY:47500", ["STATE:09"]],
    ["NAME", "PLACE:*", ["STATE:13", "CONCITY:03436"]],
    ["NAME", "PLACE:03440", ["STATE:13", "CONCITY:03436"]],
    ["NAME", "american%20indian%20tribal%20subdivision/remainder:*", ["AIANNH:*"]],
    ["NAME", "american%20indian%20tribal%20subdivision/remainder:*", ["AIANNH:0605"]],
    ["NAME", "american%20indian%20tribal%20subdivision/remainder:600", ["AIANNH:0605"]],
    ["NAME", "AIAANA:*"],
    ["NAME", "AIAANA:0155"],
    ["NAME", "AIAHHL:*"],
    ["NAME", "AIAHHL:0305"],
    ["NAME", "TTRACT:*", ["AIANNH:0020"]],
    ["NAME", "TTRACT:T00900", ["AIANNH:0020"]],
    ["NAME", "TBG:*", ["AIANNH:0020", "TTRACT:T00400"]],
    ["NAME", "TBG:B", ["AIANNH:0020", "TTRACT:T00400"]],
    ["NAME", "STATE:*", ["AIANNH:6070"]],
    ["NAME", "STATE:02", ["AIANNH:6070"]],
    ["NAME", "place%20remainder:*", ["AIANNH:9550", "STATE:01"]],
    ["NAME", "place%20remainder:80376", ["AIANNH:9550", "STATE:01"]],
    ["NAME", "COUNTY:*", ["AIANNH:2865", "STATE:01"]],
    ["NAME", "COUNTY:053", ["AIANNH:2865", "STATE:01"]],
    ["NAME", "AIAANA:*", ["STATE:01"]],
    ["NAME", "AIAANA:9820", ["STATE:01"]],
    ["NAME", "AIAHHL:*", ["STATE:04"]],
    ["NAME", "AIAHHL:4200", ["STATE:04"]],
    ["NAME", "STATE:*", ["AIANNH:1310", "american%20indian%20tribal%20subdivision/remainder:700"]],
    ["NAME", "STATE:04", ["AIANNH:1310", "american%20indian%20tribal%20subdivision/remainder:700"]],
    ["NAME", "TTRACT:*", ["american%20indian%20area%20reservation%20only:0020"]],
    ["NAME", "TTRACT:T00900", ["american%20indian%20area%20reservation%20only:0020"]],
    ["NAME", "TTRACT:*", ["AIAHHL:0010"]],
    ["NAME", "TTRACT:T00100", ["AIAHHL:0010"]],
    ["NAME", "TBG:*", ["american%20indian%20area%20reservation%20only:0010", "TTRACT:T00100"]],
    ["NAME", "TBG:C", ["american%20indian%20area%20reservation%20only:0010", "TTRACT:T00100"]],
    ["NAME", "TBG:*", ["AIAHHL:0020", "TTRACT:T00800"]],
    ["NAME", "TBG:C", ["AIAHHL:0020", "TTRACT:T00800"]],
    ["NAME", "SUBMCD:*", ["STATE:72", "COUNTY:005", "COUSUB:00788"]],
    ["NAME", "SUBMCD:81675", ["STATE:72", "COUNTY:005", "COUSUB:00788"]]
  ]
end
