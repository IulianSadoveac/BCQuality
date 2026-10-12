---
bc-version: [all]
domain: data-modeling
keywords: [ordering, sequence, setup, sync, upload, publish, stale-value, move-call, overwrite]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Write a value before the step that reads or publishes it

## Description

Setup routines, demo-data builders, posting and integration code run fixed sequences of steps. Some steps take a copy of the data and pass it on: they upload it to an external service, export it, post it, cache it, or clear a "dirty" flag once they are done. A value written after such a step never reaches the copy. The copy keeps the old value until something runs that step again, which may happen only on a timer, only in some localizations, or never.

Ordering defects do not show in the diff. The changed line is valid on its own, and the step that already read the old value is a few lines earlier in another object. Moving an existing call is especially risky: the diff shows only the move, not what the steps it now runs after have already read.

A related sign: a sequence that sets a value and then lets a later step reset it, so the value has to be set again afterwards. That works, but the code is fighting itself. Each new write has to know the hidden order, which is how this defect happens.

## Best Practice

For each field the change writes, find its readers with `findReferences`. Pay most attention to readers that pass the data on: upload, sync, export, post, cache, or clear a dirty flag. Confirm the write runs before each of those readers in the sequence. When the change adds, moves or reorders a call, go through every step between the old and new position and note what each one reads and writes. When the write has to come after a step that passes data on, run that step again. Make sure it will actually run again, for example by setting the force/dirty flag that makes it upload. Do not just call it.

Judge the result where the requirement is visible, which is often outside Business Central. "Field is optional" means optional in every client that uses the setup, not only on the BC page.

When a later step resets a value the sequence already set, note it in the review as a design smell (minor). Prefer setting the value once where it is created, or making the resetting step respect it, over adding another write after it.

See sample: [`write-before-the-step-that-reads-it.good.al`](write-before-the-step-that-reads-it.good.al).

## Anti Pattern

A setup procedure calls `SetupOnlineService()`, which uploads the field setup and clears the force-update flag. A later line then sets `Mandatory := false` on one field. The change was a deliberate move of that call to after the upload, so the diff looked harmless. Business Central shows the field as optional, but the mobile and web clients still require it until a later upload, which may never come.

See sample: [`write-before-the-step-that-reads-it.bad.al`](write-before-the-step-that-reads-it.bad.al).
