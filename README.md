# GraphQL slack updater

Provides a weekly slack update for changes to GraphQL servers in Artsy.

### Meta

-   **State:** production
-   **Production:** [travis-ci.org/artsy/graphql-slack-updater](https://travis-ci.org/artsy/graphql-slack-updater/builds)
-   **Point People:** [@orta](https://github.com/orta)

## Why?

There are 5 GraphQL APIs in differing states of production at Artsy. This repo let's us use the type system in GraphQL to keep everyone up to date with the differences in APIs. It's inspired by GitHub's [GraphQL CHANGELOG](https://developer.github.com/v4/changelog/) but this is a weekly Slack message.

_This is currently built _just_ for Artsy infrastructure._ It's probably not too hard to turn into something more generic so that others can use it. Just let us know in the issues that it's worth the extra abstraction.

## How it works?

This repo uses the Travis CI scheduled tasks feature to execute a weekly notification for changes to our GraphQL APIs. 

#### On a CI run:

- It [downloads our last GraphQL APIs from S3](https://github.com/artsy/graphql-slack-updater/blob/master/src/download_old.rb).
- Clones our GraphQL repos (see [servers/](https://github.com/artsy/graphql-slack-updater/tree/master/servers)) and requests a .graphql file for their schema
- It [compares the schemas and sends a slack message](https://github.com/artsy/graphql-slack-updater/blob/master/src/compare.rb) using [graphql-schema_comparator](https://github.com/xuorig/graphql-schema_comparator).
- It [uploads the generated .graphql files to S3](https://github.com/artsy/graphql-slack-updater/blob/master/src/upload_new.rb) so that next week we can compare it with the new one.

### ENV Vars

- `AWS_ACCESS_KEY` - The AWS access key for a user with READ/PUT/LIST access to your S3 bucket
- `AWS_SECRET_KEY` -  The AWS secret for that user
- `SLACK_WEBHOOK_URL` - The internal webhook URL for the CI run
