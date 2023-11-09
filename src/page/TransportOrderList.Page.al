page 50111 "Transport Order List"
{
    PageType = List;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTable = "Transport Order Header";
    Editable = false;
    InsertAllowed = true;
    Caption = 'Transport Orders';
    DataCaptionFields = "No.", "Driver No.";
    CardPageID = "Transport Order";
    QueryCategory = 'Transport Order List';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Driver No."; Rec."Driver No.")
                {

                }
                field("Auto Transporter No."; Rec."Auto Transporter No.")
                {

                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}