page 50105 Models
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Model;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(model; Rec.Model)
                {
                    Caption = 'Model';
                    ToolTip = 'Vehicle model.';

                }
            }
        }
    }
}