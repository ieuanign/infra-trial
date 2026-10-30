# infra-trial

A throwaway repository for trying out Multiplai's Infrastructure Department: one small Go service,
`greeter`, with a page at `/` and a health check at `/health`.

- `make check` runs formatting, vet and the tests. CI runs it on every pull request and on `main`.
- `make run` starts the service on `:8080` (`PORT` overrides it).
- `docker build -t greeter .` builds its image.

It has never been deployed. It will be archived once the trial is recorded.
