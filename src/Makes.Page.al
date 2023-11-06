page 50104 Makes
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Make;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(make; Rec.Make)
                {
                    Caption = 'Make';
                    ToolTip = 'Vehicle producer.';
                    
                }
            }
        }
    }
}