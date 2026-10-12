tableextension 50380 "Employee Pmt. Pref." extends Employee
{
    fields
    {
        field(50380; "Preferred Payment Method"; Code[10])
        {
            Caption = 'Preferred Payment Method';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
    }
}

codeunit 50381 "Empl. Pmt. Method Copy"
{
    [EventSubscriber(ObjectType::Table, Database::"Employee Ledger Entry", OnAfterCopyEmployeeLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure StampPaymentMethod(var EmployeeLedgerEntry: Record "Employee Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        Employee: Record Employee;
    begin
        // Snapshot of today's preference. The payment suggestion reads the entry before the
        // employee card, so a later change on the employee is ignored for this entry.
        if Employee.Get(EmployeeLedgerEntry."Employee No.") then
            EmployeeLedgerEntry."Payment Method Code" := Employee."Preferred Payment Method";
    end;
}
