codeunit 50101 "Vehicle Journal Register"
{
    Permissions = tabledata "G/L Entry" = rimd;
    TableNo = "Vehicle Journal Line";

    // error collection
    // https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-error-collection

    var
        VehJnlLine: Record "Vehicle Journal Line";
        NextEntryNo: Integer;

    trigger OnRun()
    begin
        RegisterVehJnlLine(VehJnlLine, true);
    end;

    internal procedure RegisterVehJnlLine(VehJnlLine: Record "Vehicle Journal Line"; HideDialog: Boolean)
    var
        IsHandled: Boolean;
    begin
        if not ConfirmRegisterVehJnlLine(HideDialog) then
            exit;
        OnBeforeRegisterVehJnlLine(VehJnlLine, IsHandled);
        DoRegisterVehJnlLine(VehJnlLine, IsHandled);
        OnAfterRegisterVehJnlLine(VehJnlLine);
        AcknowledgeRegisterVehJnlLine(HideDialog);
    end;

    local procedure ConfirmRegisterVehJnlLine(HideDialog: Boolean): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        ConfirmQst: Label 'Are you sure?';
        DefaultAnswer: Boolean;
    begin
        DefaultAnswer := true;

        if HideDialog then
            exit(DefaultAnswer);
        exit(ConfirmManagement.GetResponseOrDefault(ConfirmQst, DefaultAnswer));
    end;

    local procedure DoRegisterVehJnlLine(VehJnlLine: Record "Vehicle Journal Line"; IsHandled: Boolean)
    begin
        if VehJnlLine.FindSet() then
            repeat
                CheckLine(VehJnlLine);
            until VehJnlLine.Next() = 0;
        if VehJnlLine.FindSet() then
            repeat
                RegisterLine(VehJnlLine);
            until VehJnlLine.Next() = 0;
        DeleteLine(VehJnlLine);
    end;

    local procedure CheckLine(VehJnlLine: Record "Vehicle Journal Line")
    begin
        VehJnlLine.TestField("Entry No.");
        VehJnlLine.TestField("Vehicle No.");
        VehJnlLine.TestField("Operation Date");
        VehJnlLine.TestField("Operation Type");
        VehJnlLine.TestField(Description);
        VehJnlLine.TestField("Duration [min]");
        VehJnlLine.TestField("Resource No.");
        // VehJnlLine."Line No." := VehJnlLine.GetNewLineNo();
    end;

    local procedure RegisterLine(VehJnlLine: Record "Vehicle Journal Line")
    var
        VehEntry: Record "Vehicle Entry";
    begin
        InitNextEntryNo();
        VehEntry.Init();
        VehEntry.CopyFromVehJnlLine(VehJnlLine);
        VehEntry."Entry No." := NextEntryNo;
        VehEntry.Insert();
    end;

    local procedure DeleteLine(VehJnlLine: Record "Vehicle Journal Line")
    begin
        VehJnlLine.DeleteAll();
    end;

    local procedure InitNextEntryNo()
    var
        VehEntry: Record "Vehicle Entry";
        LastEntryNo: Integer;
        LastTransactionNo: Integer;
    begin
        VehEntry.LockTable();
        VehEntry.GetLastEntry(LastEntryNo, LastTransactionNo);
        NextEntryNo := LastEntryNo + 1;
    end;

    local procedure AcknowledgeRegisterVehJnlLine(HideDialog: Boolean)
    var
        AcknowledgeMsg: Label 'You successfully executed "Register VehJnlLine"';
    begin
        if not GuiAllowed or HideDialog then
            exit;
        Message(AcknowledgeMsg);
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeRegisterVehJnlLine(var VehJnlLine: Record "Vehicle Journal Line"; IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnAfterRegisterVehJnlLine(var VehJnlLine: Record "Vehicle Journal Line")
    begin
    end;
}