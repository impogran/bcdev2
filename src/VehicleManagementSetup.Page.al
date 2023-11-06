/// <summary>
/// Page Vehicle Management Setup (ID 50100).
/// </summary>
page 50100 "Vehicle Management Setup"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Vehicle Management Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Vehicle Management";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General setup settings.';

                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series';
                    ToolTip = 'Specifies no. series for vehicles.';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
