require 'slack-notifier'
require "graphql/schema_comparator"

parsed_old = File.read("schema/old/metaphysics.graphql")
parsed_new = File.read("schema/new/metaphysics.graphql")

result = GraphQL::SchemaComparator.compare(parsed_old, parsed_new)

notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]

if result.identical?
  notifier.post "No changes to Metaphysics"
else
  msgs = result.changes.map { |c| change.breaking ? "⚠️  #{change.message}" : "✅  #{change.message}" }
  notifier.post "Metaphysics: \n\n#{msgs.join("\n")}""
end
