# GraphQL Rails Example

GraphQL is a powerful tool for API design, acting essentially as database schema definition and transport layer.

This repository stands as a quasi-reference for the ruby-graphql gem in a working rails codebase, ideally in a way that covers as many of the features as possible; with some 'reasonably ok practices'.

Currently, the example includes:

* Writing feature tests in cucumber-js with apollo
* Registration via email and password
* Authentication via access tokens and email and passwords

## Running the example

This is written in ruby 2.5 and the feature tests are relying on node 9+. The database is sqlite for ease of installation purposes.

I recommend running the app on port 5000, using `bin/rails s -p 5000`

Tests are ran by executing `npx cucumber-js`

