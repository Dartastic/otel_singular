# Changelog

## [0.1.0-beta.1-wip]

### Added

- Initial release.
- `tracedSingular<T>(...)` — wraps a Singular API / S2S call in a
  CLIENT-kind span with mobile-attribution attributes: install, device,
  user, network/campaign/adset/creative, conversion value, revenue,
  reengagement and reinstall flags.
- `rpc.system=singular`, `rpc.method=<operation>`.
- Zone-scoped suppression via `runWithoutSingularInstrumentation()` /
  `Async()`.
