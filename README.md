# hostnamer-client

Application to test if DNS round-robin on Docker Cloud is good enough
load balancing for our microservices.

## Environment Variables

The basics from Microservice, plus:

* `HOSTNAMER_SERVER`: The Hostnamer service to use, with protocol. Like
  "http://hostnamer".
* `HOSTNAMER_KEY`: the authentication key to use for the hostnamer service

## Endpoints

* `GET /distribution?count=N`: Returns a JSON object with a property for each
  unique hostname returned whose value is the number of times that hostname
  was returned.
* `GET /version`: Regular version endpoint for all Fuzzy.io services.

## Authorization

Uses standard fuzzy.io-microservice `APP_KEY` authorization.
