codeunit 50373 "Demo Setup"
{
    procedure Run()
    begin
        CreateFieldSetup();
        SetDescriptionOptional(); // final field values are in place before anything reads them
        SetupOnlineService(); // uploads the field setup as it really is
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
