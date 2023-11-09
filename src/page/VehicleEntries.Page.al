page 50106 "Vehicle Entries"
{
    ApplicationArea = All;
    Caption = 'Vehicle Entries';
    DataCaptionFields = "Vehicle No.";
    Editable = false;
    PageType = List;
    SourceTable = "Vehicle Entry";
    SourceTableView = sorting("Entry No.")
                      order(descending);
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the entry number.';
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the vehicle number.';
                }
                field("Operation Date"; Rec."Operation Date")
                {
                    ToolTip = 'Specifies the date when the entry was posted.';
                }
                field("Operation Type"; Rec."Operation Type")
                {
                    ToolTip = 'Specifies the type of operation.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the entry description.';
                }
                field("Duration [min]"; Rec."Duration [min]")
                {
                    ToolTip = 'Specifies the entry duration in minutes.';
                }
                field("Resource No."; Rec."Resource No.")
                { 
                    ToolTip = 'Specifies the resource number.';
                }
                
            }
        }
    }


}