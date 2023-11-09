table 50105 "Vehicle Journal Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            TableRelation = Vehicle;
        }
        field(3; "Operation Date"; Date)
        {
            Caption = 'Operation Date';
        }
        field(4; "Operation Type"; Enum "Operation Type")
        {
            Caption = 'Operation Type';
        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(6; "Duration [min]"; Integer)
        {
            Caption = 'Duration [min]';
        }
        field(7; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;

        }
        field(8; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    // procedure GetNewLineNo(): Integer
    // var
    //     [SecurityFiltering(SecurityFilter::Filtered)]
    //     VehicleJournalLine: Record "Vehicle Journal Line";
    // begin
    //     if VehicleJournalLine.FindLast() then
    //         exit(VehicleJournalLine."Line No." + 10000);
    //     exit(10000);
    // end;

    procedure GetNewEntryNo(): Integer
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        VehicleJournalLine: Record "Vehicle Journal Line";
    begin
        if VehicleJournalLine.FindLast() then
            exit(VehicleJournalLine."Entry No." + 1);
        exit(1);
    end;

    trigger OnInsert()
    begin
        // "Line No." := GetNewLineNo();
        "Entry No." := GetNewEntryNo();
    end;
}