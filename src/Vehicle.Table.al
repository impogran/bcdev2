/// <summary>
/// Table Vehicle (ID 50101).
/// </summary>
table 50101 Vehicle
{
    Caption = 'Vehicle';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Vehicle List";
    LookupPageID = "Vehicle Card";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                TestNoSeries();
            end;

        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(4; Model; Text[100])
        {
            Caption = 'Model';
            // TableRelation = "Model";
        }
        field(5; Make; Text[50])
        {
            Caption = 'Make';
            TableRelation = Make;
        }
        field(6; VIN; Code[20])
        {
            Caption = 'VIN';
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(8; Status; Text[50])
        {
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK1; "No.")
        {
            Clustered = true;
        }
        key(PK2; "No. Series")
        {
        }
    }

    trigger OnInsert()
    var
        VehicleManagement: Record "Vehicle Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if "No." = '' then begin
            VehicleManagement.Get();
            VehicleManagement.TestField("No. Series");
            NoSeriesManagement.InitSeries(VehicleManagement."No. Series", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    local procedure TestNoSeries()
    var
        Vehicle: Record Vehicle;
        VehicleManagement: Record "Vehicle Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        if "No." <> xRec."No." then
            if not Vehicle.Get(Rec."No.") then begin
                VehicleManagement.Get();
                NoSeriesManagement.TestManual(VehicleManagement."No. Series");
                "No. Series" := '';
            end;
    end;

    procedure AssistEdit(OldVehicle: Record Vehicle): Boolean
    var
        Vehicle: Record Vehicle;
        VehicleManagement: Record "Vehicle Management";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        with Vehicle do begin
            Vehicle := Rec;
            VehicleManagement.Get();
            VehicleManagement.TestField("No. Series");
            if NoSeriesManagement.SelectSeries(VehicleManagement."No. Series", OldVehicle."No. Series", "No. Series") then begin
                NoSeriesManagement.SetSeries("No.");
                Rec := Vehicle;
                exit(true);
            end;
        end;
    end;
}