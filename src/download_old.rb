# download older schemas from S3

graphql_bucket = "artsy-graphql-history"

# Expects a folder structure like:

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

begin
  folders = client.list_objects(bucket: graphql_bucket).contents.map(&:key)
  folders.each do |service|
    File.open("schema/old" + service + ".graphql", "wb") do |file|
      options = {
        bucket: graphql_bucket,
        key: service + "/latest.graphql"
      }
      s3.get_object(options) do |chunk|
        file.write(chunk)
      end
    end
  end

rescue Aws::S3::Errors::ServiceError
 puts "S3 Error"
 raise
end
