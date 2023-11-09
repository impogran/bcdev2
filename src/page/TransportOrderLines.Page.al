page 50108 "Transport Order Lines"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Transport Order Lines';
    InsertAllowed = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Transport Order Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Transport Order No."; Rec."Transport Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transport Order No.';

                }
                field("Line No."; Rec."Line No.")
                {
                    // Visible = false;
                    ApplicationArea = All;

                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Description 2';
                }
                field("Start POI"; Rec."Start POI")
                {
                    ApplicationArea = All;
                    Caption = 'Start POI';
                }
                field("End POI"; Rec."End POI")
                {
                    ApplicationArea = All;
                    Caption = 'End POI';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }
        }
    }
}