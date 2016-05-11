# hostnamer

Application to test if DNS round-robin on Docker Cloud is good enough
load balancing for our microservices.

## Environment Variables

Just the basics from Microservice.

## Endpoints

* `GET /hostname`: Returns a single string with the hostname of the server.
* `GET /version`: Regular version endpoint for all Fuzzy.io services.

## Authorization

Uses standard fuzzy.io-microservice `APP_KEY` authorization.
