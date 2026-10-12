codeunit 50370 "Field Setup Demo"
{
    procedure MakeDescriptionOptional()
    var
        FieldSetup: Record "Field Setup";
    begin
        FieldSetup.SetRange(Code, 'DESCRIPTION');
        // RunTrigger defaults to false: "Field Setup".OnModify, which sets
        // "Force Field Update" so the next sync uploads the setup again, never runs.
        // BC shows the field as optional; the online clients keep it mandatory.
        FieldSetup.ModifyAll(Mandatory, false);
    end;
}
