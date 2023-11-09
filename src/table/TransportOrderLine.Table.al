table 50110 "Transport Order Line"
{
    Caption = 'Transport Order Line';
    DrillDownPageID = "Transport Order Subform";
    LookupPageID = "Transport Order Subform";
    Permissions = tabledata "Transport Order Line" = m;
    //dodać description, jak wybierze sie vehicle no to powinien sie wstawić opis; onvalidate

    fields
    {
        field(1; "Transport Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Transport Order No.';
            TableRelation = "Transport Order Header";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
        }
        field(3; "Vehicle No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vehicle No.';
            TableRelation = Vehicle;

            trigger OnValidate()
            var
                Vehicle: Record Vehicle;
                TransportOrderHeader: Record "Transport Order Header";
            begin
                if Vehicle.Get(Rec."Vehicle No.") then begin
                    Description := Format(Vehicle.Description);
                    "Description 2" := Format(Vehicle."Description 2");
                end;
                if "Vehicle No." = '' then begin
                    Description := '';
                    "Description 2" := '';
                end;
                if TransportOrderHeader.Get("Transport Order No.") then
                    "Start Date" := TransportOrderHeader."Starting Date";
                    // add przepisywanie poi
            end;
        }
        field(31; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(32; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(4; "Start POI"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Start POI';
            TableRelation = "Point of Interest";
        }
        field(5; "End POI"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'End POI';
            TableRelation = "Point of Interest";
        }
        field(6; "Start Date"; DateTime)
        {
            Caption = 'Start Date';
        }
        field(7; "End Date"; DateTime)
        {
            Caption = 'End Date';
        }
    }

    keys
    {
        key(Key1; "Transport Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    
}