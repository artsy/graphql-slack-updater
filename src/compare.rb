require "slack-notifier"
require "graphql/schema_comparator"

parsed_old = File.read("schema/old/metaphysics.graphql")
parsed_new = File.read("schema/new/metaphysics.graphql")

result = GraphQL::SchemaComparator.compare(parsed_old, parsed_new)

notifier = Slack::Notifier.new ENV["SLACK_WEBHOOK_URL"]

if result.identical?
  notifier.post text: "No changes to Metaphysics"
else
  msgs = result
         .changes
         .map { |c| c.breaking ? "⚠️  #{c.message}" : "✅  #{c.message}" }

  notifier.post text: "Metaphysics: \n\n#{msgs.join("\n")}"
end
