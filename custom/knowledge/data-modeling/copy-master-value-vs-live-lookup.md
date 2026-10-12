---
bc-version: [all]
domain: data-modeling
keywords: [copy, snapshot, master-data, ledger-entry, payment-method, stale-value, precedence, posting]
technologies: [al]
countries: [w1]
application-area: [all]
---

# Copying a master value onto an entry freezes it: check which source the readers prefer

## Description

Posting code often copies values from master records (vendor, employee, customer, setup) onto journal lines and ledger entries, for example a payment method, a recipient bank account, an e-mail address, dimensions or posting groups. A copy is a snapshot. When later processes (payment suggestions, exports, reminders) read the entry's value before the master value, any later change to the master record is ignored for entries that are already posted.

That is correct for values that must reflect the posting moment, such as posting groups, dimensions and amounts. It is wrong for values that describe a current preference, such as a payment method, recipient bank account or contact e-mail. A user changes the employee from "manual" to "bank transfer", and the entries posted earlier still say "manual".

The defect does not show in the diff. The copy looks harmless. The reader that ranks the entry above the master record often lives in another app that extends the table.

## Best Practice

Before adding a copy from a master record to an entry, find every reader of the target field. Use `findReferences`, and search the other apps that extend the table. Note which source each reader prefers.

- **Copy** only when the value must be historical, or when no reader can look the master value up when it uses it.
- **Leave the entry blank** when a reader already falls back to the master value when the entry is blank.
- **If the copy is required:** fill the field only when it is blank, say in a comment which reader depends on it, and make sure there is a way to refresh it, such as a refresh option on the suggestion or an editable entry field.

See sample: [`copy-master-value-vs-live-lookup.good.al`](copy-master-value-vs-live-lookup.good.al).

## Anti Pattern

Subscribing to `OnAfterCopyEmployeeLedgerEntryFromGenJnlLine` to stamp the employee's current payment method on every new employee ledger entry, while the payment app resolves the payment method in the order "report parameter, then ledger entry, then employee card". The employee later switches to bank transfer. The entries posted before the switch keep the old method and are suggested as manual payments, so the employee is never paid.

Out of scope: values that must stay historical (amounts, currency, dimensions, posting groups, document references).

See sample: [`copy-master-value-vs-live-lookup.bad.al`](copy-master-value-vs-live-lookup.bad.al).
