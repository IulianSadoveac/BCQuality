codeunit 50391 "Posting Telemetry Good"
{
    procedure LogJournalPostingDiscovered()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0300', 'Journal Posting', Enum::"Feature Uptake Status"::Discovered);
    end;

    procedure LogJournalPostingSetUp()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0301', 'Journal Posting', Enum::"Feature Uptake Status"::"Set up");
    end;

    procedure LogInvoicePostingDiscovered()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0303', 'Invoice Posting', Enum::"Feature Uptake Status"::Discovered);
    end;

    procedure LogInvoicePostingSetUp()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0303', 'Invoice Posting', Enum::"Feature Uptake Status"::"Set up");
    end;

    procedure LogInvoicePostingUsed()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogUptake('EXP0304', 'Invoice Posting', Enum::"Feature Uptake Status"::Used);
    end;

    procedure LogInvoiceCreationFailed(ErrorText: Text)
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
    begin
        FeatureTelemetry.LogError('EXP0310', 'Invoice Posting', 'Create purchase invoice', ErrorText);
    end;
}
