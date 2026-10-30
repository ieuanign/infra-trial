---
schema_version: 1
branching:
  trunk:
    value: "main"
    mark: client
  merge_method:
    value: "rebase"
    mark: suggested
  check_command:
    value: "make check"
    mark: client
  derived_files:
    value:
      - "go.sum"
    mark: suggested
paths:
  tools:
    value: "tools/"
    mark: suggested
  wizard:
    value: "tools/wizard/"
    mark: suggested
infrastructure_as_code:
  tool:
    value: "opentofu"
    mark: suggested
  path:
    value: "infra/"
    mark: suggested
services:
  greeter:
    paths:
      value:
        - "Dockerfile"
        - "go.mod"
        - "*.go"
      mark: client
    mobile_app:
      value: false
      mark: client
environments:
  staging:
    runtime:
      value: "compose"
      mark: suggested
    provider:
      value: "docker"
      mark: client
    deployed_by:
      value: "trunk-push"
      mark: suggested
    health_check_url:
      value: "http://127.0.0.1:18080/health"
      mark: client
    monitoring:
      value: "added"
      mark: suggested
    remediation:
      enabled:
        value: false
        mark: suggested
    scale:
      min:
        value: 1
        mark: suggested
      max:
        value: 2
        mark: suggested
release:
  by_rule:
    enabled:
      value: false
      mark: suggested
  e2e_tests:
    enabled:
      value: false
      mark: suggested
  tag:
    enabled:
      value: false
      mark: suggested
  soft_release:
    enabled:
      value: false
      mark: suggested
previews:
  enabled:
    value: false
    mark: suggested
right_sizing:
  down_below_percent:
    value: 40
    mark: suggested
  up_above_percent:
    value: 80
    mark: suggested
tools:
  proxy:
    value: "traefik"
    mark: suggested
  ingress:
    value: null
    mark: suggested
  certificates:
    value: "none"
    mark: client
  monitoring:
    value: "prometheus-loki-grafana"
    mark: suggested
  deployment:
    value: null
    mark: suggested
  mobile_build:
    value: null
    mark: suggested
---

# Delivery policy

The front matter above is what tools read; this body says the same for people. Each rule carries its
mark: `client` (the owner's own, or observed and kept), `suggested` (the suggestion, accepted) or
`required` (a fixed rule the repository breaks today, with the change needed).

## Branching

- Trunk (`branching.trunk`): "main" — client.
- Merge method (`branching.merge_method`): "rebase" — suggested.
- Check command (`branching.check_command`): "make check" — client.
- Derived files (`branching.derived_files`): "go.sum" — suggested.

## Paths

- Tools path (`paths.tools`): "tools/" — suggested.
- Wizard scripts path (`paths.wizard`): "tools/wizard/" — suggested.

## Infrastructure as code

- Tool (`infrastructure_as_code.tool`): "opentofu" — suggested.
- Path (`infrastructure_as_code.path`): "infra/" — suggested.

## Services

- greeter, built from (`services.greeter.paths`): "Dockerfile", "go.mod", "*.go" — client.
- greeter, mobile app (`services.greeter.mobile_app`): false — client.

## Environments

- staging, runtime (`environments.staging.runtime`): "compose" — suggested.
- staging, provider (`environments.staging.provider`): "docker" — client.
- staging, deployed by (`environments.staging.deployed_by`): "trunk-push" — suggested.
- staging, health check (`environments.staging.health_check_url`): "http://127.0.0.1:18080/health" — client.
- staging, monitoring (`environments.staging.monitoring`): "added" — suggested.
- staging, remediation (`environments.staging.remediation.enabled`): false — suggested.
- staging, scale minimum (`environments.staging.scale.min`): 1 — suggested.
- staging, scale maximum (`environments.staging.scale.max`): 2 — suggested.

## Release

- Release by rule (`release.by_rule.enabled`): false — suggested.
- End-to-end tests in the pipeline (`release.e2e_tests.enabled`): false — suggested.
- Tag (`release.tag.enabled`): false — suggested.
- Soft release (`release.soft_release.enabled`): false — suggested.

## Previews

- Previews (`previews.enabled`): false — suggested.

## Right-sizing

- Size down below (`right_sizing.down_below_percent`): 40 — suggested.
- Size up above (`right_sizing.up_above_percent`): 80 — suggested.

## Tools

- Proxy (`tools.proxy`): "traefik" — suggested.
- Ingress (`tools.ingress`): null — suggested.
- Certificates (`tools.certificates`): "none" — client.
- Monitoring (`tools.monitoring`): "prometheus-loki-grafana" — suggested.
- Deployment (`tools.deployment`): null — suggested.
- Mobile build (`tools.mobile_build`): null — suggested.
