table 50107 "Transport Order Header"
{
    Caption = 'Transport Order Header';
    DataCaptionFields = "No.", "Driver No.";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';


            trigger OnValidate()
            begin
                TestNoSeries();
            end;

        }
        field(2; "Driver No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Driver No.';
            TableRelation = Resource where(Type = const(Person));

        }
        field(3; "Auto Transporter No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Auto Transporter No.';
            TableRelation = Resource where(Type = const(Machine));

        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(5; "Starting Date"; DateTime)
        {
            Caption = 'Starting Date';
            trigger OnValidate()
            begin
                UpdateTransportOrderLinesByFieldNo(FieldNo("Starting Date"), CurrFieldNo <> 0);
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        VehicleManagementSetup: Record "Vehicle Management Setup";
        TransportOrderLine: Record "Transport Order Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        TransportOrderDateModifiedLbl: Label 'You have modified Starting Date.\\Do you want to update the lines?';
        TransportOrderHeaderIsTemporaryLbl: Label 'Transport Order Header must be not temporary.', Locked = true;
        TransportOrderHeaderDoesNotExistLbl: Label 'Transport Order Header must exist.', Locked = true;
        TransportOrderHeaderCannotModifyLbl: Label 'Cannot modify Transport Order Header.', Locked = true;
        TransportOrderLinesCategoryLbl: Label 'Transport Order Lines', Locked = true;


    local procedure TestNoSeries()
    var
        Vehicle: Record Vehicle;
    begin

        if "No." <> xRec."No." then
            if not Vehicle.Get(Rec."No.") then begin
                VehicleManagementSetup.Get();
                NoSeriesManagement.TestManual(VehicleManagementSetup."Vehicle Nos.");
                "No. Series" := '';
            end;
    end;

    procedure AssistEdit(OldTransportOrderHeader: Record "Transport Order Header"): Boolean
    var
        TransportOrderHeader: Record "Transport Order Header";
        v: Page 8907;
    begin
        TransportOrderHeader := Rec;
        VehicleManagementSetup.Get();
        VehicleManagementSetup.TestField("Vehicle Nos.");
        if NoSeriesManagement.SelectSeries(VehicleManagementSetup."Vehicle Nos.", OldTransportOrderHeader."No. Series", TransportOrderHeader."No. Series") then begin
            NoSeriesManagement.SetSeries(TransportOrderHeader."No.");
            Rec := TransportOrderHeader;
            exit(true);
        end;
    end;

    procedure UpdateTransportOrderLinesByFieldNo(ChangedFieldNo: Integer; AskQuestion: Boolean)
    var
        "Field": Record "Field";
        Question: Text[250];
        IsHandled: Boolean;
        HideDialog: Boolean;
    begin
        if Rec.IsTemporary() then begin
            Session.LogMessage('0000G95', TransportOrderHeaderIsTemporaryLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', TransportOrderLinesCategoryLbl);
            exit;
        end;

        if IsNullGuid(Rec.SystemId) then begin
            Session.LogMessage('0000G96', TransportOrderHeaderDoesNotExistLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', TransportOrderLinesCategoryLbl);
            exit;
        end;

        IsHandled := false;
        if IsHandled then
            exit;

        if not TransportOrderLinesExist() then
            exit;

        if not Field.Get(DATABASE::"Transport Order Header", ChangedFieldNo) then
            Field.Get(DATABASE::"Transport Order Line", ChangedFieldNo);

        if AskQuestion then begin
            Question := StrSubstNo(TransportOrderDateModifiedLbl, Field."Field Caption");
            if not ConfirmChangeField(HideDialog) then
                exit;
        end;

        TransportOrderLine.LockTable();
        if not Rec.Modify() then begin
            Session.LogMessage('0000G97', TransportOrderHeaderCannotModifyLbl, Verbosity::Warning, DataClassification::SystemMetadata, TelemetryScope::ExtensionPublisher, 'Category', TransportOrderLinesCategoryLbl);
            exit;
        end;

        TransportOrderLine.Reset();
        TransportOrderLine.SetRange("Transport Order No.", "No.");
        if TransportOrderLine.FindSet() then
            repeat
                IsHandled := false;
                if not IsHandled then
                    case ChangedFieldNo of
                        FieldNo("Starting Date"):
                            if TransportOrderLine."Transport Order No." <> '' then
                                TransportOrderLine.Validate("Start Date", "Starting Date");
                    //add start poi case
                    end;
                TransportOrderLine.Modify(true);
            until TransportOrderLine.Next() = 0;
    end;

    procedure TransportOrderLinesExist(): Boolean
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        TransportOrderLine.Reset();
        TransportOrderLine.SetRange("Transport Order No.", "No.");
        exit(not TransportOrderLine.IsEmpty());
    end;

    local procedure ConfirmChangeField(HideDialog: Boolean): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        DefaultAnswer: Boolean;
    begin
        DefaultAnswer := true;

        if HideDialog then
            exit(DefaultAnswer);
        exit(ConfirmManagement.GetResponseOrDefault(TransportOrderDateModifiedLbl, DefaultAnswer));
    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            VehicleManagementSetup.Get();
            VehicleManagementSetup.TestField("Transport Order Nos.");
            NoSeriesManagement.InitSeries(VehicleManagementSetup."Transport Order Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

}