/// <summary>
/// Page Vehicle Role Center (ID 50103).
/// </summary>
page 50103 "Vehicle Role Center"
{
    Caption = 'Vehicle Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {

        }
    }

    actions
    {
        area(Sections)
        {
            group(Tables)
            {
                action(Make)
                {
                    Caption = 'Make';
                    RunObject = Page Makes;
                    ApplicationArea = All;
                }
                action(Model)
                {
                    Caption = 'Model';
                    RunObject = Page Models;
                    ApplicationArea = All;
                }
                action(Vehicle)
                {
                    Caption = 'Vehicle';
                    RunObject = Page "Vehicle List";
                    ApplicationArea = All;
                }
            }
        }
        area(Embedding)
        {
            action("Vehicle Management Setup")
            {
                Caption = 'Vehicle Management Setup';
                RunObject = Page "Vehicle Management Setup";
                ApplicationArea = All;
            }
        }
    }
}