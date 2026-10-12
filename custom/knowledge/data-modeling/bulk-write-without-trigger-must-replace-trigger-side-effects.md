---
bc-version: [all]
domain: data-modeling
keywords: [modifyall, modify, runtrigger, onmodify, side-effect, sync-flag, resync, setup]
technologies: [al]
countries: [w1]
application-area: [all]
---

# A write that skips `OnModify` must do the trigger's side effects itself

## Description

`ModifyAll(Field, Value)` and `Modify()` do not run `OnModify`: `RunTrigger` defaults to `false`. A plain field assignment does not run `OnValidate`. Besides changing the record, these triggers often do work for other parts of the system: they set a "needs sync" or "force update" flag, write a change log, queue a job, or update a dependent table. Skipping the trigger keeps the new value in the table but loses those side effects. The value then looks right in Business Central while the systems that depend on the side effect, such as an external portal, a mobile app or a cache, keep the old value.

The skipped trigger is in another object, so the defect does not show in the diff. Open the table and read `OnModify`, plus the field's `OnValidate` for an assignment, before deciding the write is safe.

## Best Practice

Before using `ModifyAll` without its trigger argument, `Modify()`/`Modify(false)` or a plain field assignment on a non-temporary table, read the table's `OnModify` and the field's `OnValidate`. List what they do beyond changing the field. Then either run the trigger (`ModifyAll(Field, Value, true)`, `Modify(true)`, `Validate`), or call the side-effect procedure yourself right after the write and say so in a comment. For example, set the force-update flag or call the sync procedure.

See sample: [`bulk-write-without-trigger-must-replace-trigger-side-effects.good.al`](bulk-write-without-trigger-must-replace-trigger-side-effects.good.al).

## Anti Pattern

`ModifyAll(Mandatory, false)` on a field-setup table whose `OnModify` sets a "Force Field Update" flag that tells the next sync to upload the setup again. The write skips the trigger and nothing else sets the flag, so the next sync sees no change and the external system keeps the old value. The reviewer only checked the changed line, never the trigger it skipped.

Out of scope: temporary records, buffer and staging tables, tables whose `OnModify`/`OnValidate` only change the record itself, and bulk writes where skipping the trigger is the documented intent, such as an upgrade codeunit.

See sample: [`bulk-write-without-trigger-must-replace-trigger-side-effects.bad.al`](bulk-write-without-trigger-must-replace-trigger-side-effects.bad.al).
