require "aws-sdk-s3"

graphql_bucket = "artsy-graphql-schemas"

# download older schemas from S3

# Expects a folder structure like:
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

s3 = Aws::S3::Client.new(region: "us-east-1")
all_files = s3.list_objects(bucket: graphql_bucket).contents.map(&:key)
folders = all_files.select { |f| f.end_with? "latest.graphql" }
                   .map { |f| f.split("/").first }

folders.each do |service|
  File.open("schema/old/" + service + ".graphql", "wb") do |file|
    options = {
      bucket: graphql_bucket,
      key: service + "/latest.graphql"
    }
    s3.get_object(options) do |chunk|
      file.write(chunk)
    end
  end
end
