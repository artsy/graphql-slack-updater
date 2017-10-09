require "aws-sdk-s3"

graphql_bucket = "artsy-graphql-schemas"

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

s3 = Aws::S3::Resource.new(region: "us-east-1")
date = Time.now.strftime("%d-%b-%Y")

Dir.glob("schema/new/*.graphql").each do |schema|
  name = File.basename(schema, ".graphql")

  obj = s3.bucket(graphql_bucket).object(name + "/latest.graphql")
  obj.upload_file(schema)

  obj = s3.bucket(graphql_bucket).object(name + "/" + date + ".graphql")
  obj.upload_file(schema)
end
