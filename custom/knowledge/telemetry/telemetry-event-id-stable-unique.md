---
bc-version: [17..]
domain: telemetry
keywords: [telemetry, event-id, featuretelemetry, loguptake, uptake-status, shared-id, renumber, stable-id]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Telemetry event IDs: no overlaps, except the uptake states of one feature, and never renumber a shipped ID

## Description

`Session.LogMessage` and the `Feature Telemetry` codeunit (`LogUptake`, `LogUsage`, `LogError`) take the event ID as their first parameter. Queries, dashboards and alerts that consumers built over earlier releases filter on that ID. Two rules follow from this. Each event gets its own ID, so consumers can tell the events apart. And an ID that has shipped keeps its meaning, so existing data stays comparable across releases.

`LogUptake` is the one place where a shared ID does no harm. It records the uptake state of a single feature. Every uptake event carries the feature name and the state (`Discovered`, `Set up`, `Used`) as custom dimensions, and the state is in the message too. Two states of the same feature that log the same ID are still separable in the data, so the overlap is accepted.

The costly mistake runs the other way. A reviewer or developer spots two calls with the same ID and "fixes" the duplicate by giving one of them a new ID. If the ID has shipped, the change splits one series into two at the release date. Old versions keep sending the old ID, so the data is never consistent again.

## Best Practice

Give every new telemetry event its own ID, unique within the extension's telemetry catalogue.

When a change adds or edits a telemetry ID, first list every other use of the same ID in the extension, with the file, the call, the feature name and the uptake state.

- **Accept** an overlap when all calls are `LogUptake` calls for the same feature name with different uptake states.
- **Report** any other overlap, such as two features, two event kinds, or a `LogUptake` and a `LogMessage`, `LogUsage` or `LogError` call sharing one ID.
- **Treat a shipped ID as fixed.** Before changing an existing ID, check whether a released version already sends it. If it does, keep it, even when it overlaps. An accepted overlap is never a reason to renumber.

See sample: [`telemetry-event-id-stable-unique.good.al`](telemetry-event-id-stable-unique.good.al).

## Anti Pattern

Reusing one ID for different events: two features, or an uptake state and an error or usage event. Consumers that filter on the ID then count events that have nothing to do with each other.

Changing the ID of a call that has already shipped, for example moving the `Discovered` state of a feature to a new ID because its `Set up` state logs the same ID. The two states were already separable. The change only breaks every existing query on the old ID. Also report a review comment that proposes such a change.

See sample: [`telemetry-event-id-stable-unique.bad.al`](telemetry-event-id-stable-unique.bad.al).
