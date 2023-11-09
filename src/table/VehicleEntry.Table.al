table 50104 "Vehicle Entry"
{
    Caption = 'Vehicle Entry';
    DrillDownPageID = "Vehicle Entries";
    LookupPageID = "Vehicle Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
        }
        field(2; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            Editable = false; 
        }
        field(3; "Operation Date"; Date)
        {
            Caption = 'Operation Date';
            Editable = false;
        }
        field(4; "Operation Type"; Enum "Operation Type")
        {
            Caption = 'Operation Type';
            Editable = false;
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
            Editable = true;
        }
        field(6; "Duration [min]"; Integer)
        {
            Caption = 'Duration [min]';
            Editable = false;
        }
        field(7; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Vehicle No.", "Resource No.")
        {

        }
    }

    procedure GetLastEntry(var LastEntryNo: Integer; var LastTransactionNo: Integer)
    var
        FindRecordManagement: Codeunit "Find Record Management";
        FieldNoValues: List of [Integer];
    begin
        FieldNoValues.Add(FieldNo("Entry No."));
        FindRecordManagement.GetLastEntryIntFieldValues(Rec, FieldNoValues);
        LastEntryNo := FieldNoValues.Get(1);
    end;

    procedure CopyFromVehJnlLine(VehJnlLine: Record "Vehicle Journal Line")
    begin
        "Vehicle No." := VehJnlLine."Vehicle No.";
        "Operation Date" := VehJnlLine."Operation Date";
        "Operation Type" := VehJnlLine."Operation Type";
        Description := VehJnlLine.Description;
        "Duration [min]" := VehJnlLine."Duration [min]";
        "Resource No." := VehJnlLine."Resource No.";
    end;

}