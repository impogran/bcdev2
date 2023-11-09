page 50110 "Transport Order"
{
    PageType = Document;
    ApplicationArea = All;
    SourceTable = "Transport Order Header";

    //add posting

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;

                }
                field("Auto Transporter No."; Rec."Auto Transporter No.")
                {
                    ApplicationArea = All;

                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Transport Order Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Transport Order No." = field("No.");
                UpdatePropagation = Both;
            }
        }
        area(Factboxes)
        {

        }
    }
}