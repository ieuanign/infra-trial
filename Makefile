.PHONY: check run

# The one check a pull request must pass: formatting, vet and the tests.
check:
	@test -z "$$(gofmt -l .)" || { echo "gofmt would change:"; gofmt -l .; exit 1; }
	go vet ./...
	go test ./...

run:
	go run .
