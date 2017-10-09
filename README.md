# UpdateQL

Provides a weekly slack update for changes to GraphQL servers.

### Meta

-   **State:** production
-   **Production:** [travis-ci.org/artsy/graphql-slack-updater](https://travis-ci.org/artsy/graphql-slack-updater/builds)
-   **Point People:** [@orta](https://github.com/orta)

## Why?

There are 5 GraphQL APIs in differing states of production at Artsy. This repo let's us use the type system in GraphQL to keep everyone up to date with the differences in APIs. It's inspired by GitHub's [GraphQL CHANGELOG](https://developer.github.com/v4/changelog/) but this is a weekly Slack message.

## How it works?

This repo uses the Travis CI scheduled tasks feature to execute a weekly notification for changes to our GraphQL APIs. 

#### On a CI run:

- It [downloads our last GraphQL APIs from S3](https://github.com/artsy/graphql-slack-updater/blob/master/src/download_old.rb).
- Clones our GraphQL repos (see [servers/](https://github.com/artsy/graphql-slack-updater/tree/master/servers)) and requests a .graphql file for their schema
- It [compares the schemas and sends a slack message](https://github.com/artsy/graphql-slack-updater/blob/master/src/compare.rb).
- It [uploads the generated .graphql files to S3](https://github.com/artsy/graphql-slack-updater/blob/master/src/upload_new.rb) so that next week we can compare it with the new one.

