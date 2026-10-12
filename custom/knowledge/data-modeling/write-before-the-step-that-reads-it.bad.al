codeunit 50372 "Demo Setup"
{
    procedure Run()
    begin
        CreateFieldSetup();
        SetupOnlineService(); // uploads field setup, then clears "Force Field Update"
        SetDescriptionOptional(); // too late: the upload already sent Mandatory = true
        ImportDemoTransactions();
    end;

    local procedure CreateFieldSetup()
    begin
    end;

    local procedure SetupOnlineService()
    begin
    end;

    local procedure SetDescriptionOptional()
    begin
    end;

    local procedure ImportDemoTransactions()
    begin
    end;
}
