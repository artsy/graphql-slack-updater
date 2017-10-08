graphql_bucket = "artsy-graphql-history"

# We want to make a folder structure like:
#
# metaphyics/
#  latest.graphql
#  24-11-2017.graphql
#  17-11-2017.graphql
#  10-11-2017.graphql
# bearden/
#  latest.graphql
#  24-11-2017.graphql
#  17-11-2017.graphql
#  10-11-2017.graphql
# ...
#
# By taking the .graphql files inside new
# and uploading them as both latest, and today''s date'

date = Time.now.strftime("%d-%b-%Y")
Dir.glob("schema/new/*.graphql").each do |schema|
  File.open(schema, "rb") do |file|
    s3.put_object(bucket: graphql_bucket, key: schema + "/latest", body: file)
    s3.put_object(bucket: graphql_bucket, key: schema + "/" + date, body: file)
  end
end
