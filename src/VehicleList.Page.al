/// <summary>
/// Page Vehicle List (ID 50101).
/// </summary>
page 50101 "Vehicle List"
{
    ApplicationArea = Basic, Suite, Assembly, Service;
    Caption = 'Vehicles';
    CardPageID = "Vehicle List";
    Editable = false;
    PageType = List;
    SourceTable = Vehicle;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Vehicle''s no.';

                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                    ToolTip = 'Vehicle''s description.';

                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2';
                    ToolTip = 'Vehicle''s description 2.';
                    Visible = false;

                }
                field(model; Rec.Model)
                {
                    Caption = 'Model';
                    ToolTip = 'Vehicle''s model.';
                }
                field(make; Rec.Make)
                {
                    Caption = 'Make';
                    ToolTip = 'Vehicle''s make.';

                }
                field(vin; Rec.VIN)
                {
                    Caption = 'VIN';
                    ToolTip = 'Vehicle''s VIN.';

                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                    ToolTip = 'Vehicle''s no. series.';
                    Visible = false;

                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    Tooltip = 'Vehicle''s status.';
                }
            }
        }
    }
}