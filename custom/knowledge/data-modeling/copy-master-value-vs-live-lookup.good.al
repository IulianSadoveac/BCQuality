tableextension 50382 "Employee Pmt. Pref." extends Employee
{
    fields
    {
        field(50382; "Preferred Payment Method"; Code[10])
        {
            Caption = 'Preferred Payment Method';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
    }
}

codeunit 50383 "Empl. Pmt. Method Resolver"
{
    // Resolve when the payment is suggested, not when the expense is posted:
    // an explicit value on the entry wins, otherwise the employee's current preference.
    procedure GetPaymentMethod(EmployeeLedgerEntry: Record "Employee Ledger Entry"): Code[10]
    var
        Employee: Record Employee;
    begin
        if EmployeeLedgerEntry."Payment Method Code" <> '' then
            exit(EmployeeLedgerEntry."Payment Method Code");
        if Employee.Get(EmployeeLedgerEntry."Employee No.") then
            exit(Employee."Preferred Payment Method");
    end;
}
