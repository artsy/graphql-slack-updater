require "graphql/schema_comparator"

parsed_old = File.read("schema/old/metaphysics.graphql")
parsed_new = File.read("schema/new/metaphysics.graphql")

result = GraphQL::SchemaComparator.compare(parsed_old, parsed_new)

if result.identical?
  puts "same"
else
  result.changes.each do |change|
    if change.breaking
      puts "⚠️  #{change.message}"
    else
      puts "✅  #{change.message}"
    end
  end
end
