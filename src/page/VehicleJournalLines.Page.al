page 50107 "Vehicle Journal Lines"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Vehicle Journal Lines';
    SourceTable = "Vehicle Journal Line";
    AutoSplitKey = true;

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
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the line number';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Register Lines")
            {
                ToolTip = 'Register created journal lines into the entries.';
                Caption = 'Register Lines';
                Image = Post;
                RunObject = Codeunit "Vehicle Journal Register";
            }
        }
    }
}