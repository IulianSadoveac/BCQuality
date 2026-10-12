codeunit 50371 "Field Setup Demo"
{
    procedure MakeDescriptionOptional()
    var
        FieldSetup: Record "Field Setup";
    begin
        FieldSetup.SetRange(Code, 'DESCRIPTION');
        // Run OnModify so it sets "Force Field Update" and the next sync uploads the change.
        FieldSetup.ModifyAll(Mandatory, false, true);
    end;
}
