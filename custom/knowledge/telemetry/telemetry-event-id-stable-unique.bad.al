codeunit 50390 "Posting Telemetry Bad"
{
    procedure LogJournalPostingDiscovered()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0300', 'Journal Posting', Enum::"Feature Uptake Status"::Discovered);
    end;

    procedure LogInvoicePostingDiscovered()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0303', 'Invoice Posting', Enum::"Feature Uptake Status"::Discovered);
    end;

    procedure LogInvoiceCreationFailed(ErrorText: Text)
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogError('EXP0303', 'Invoice Posting', 'Create purchase invoice', ErrorText);
    end;
}
