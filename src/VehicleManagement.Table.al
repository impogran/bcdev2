/// <summary>
/// Table Vehicle Management (ID 50100).
/// </summary>
table 50100 "Vehicle Management"
{
    Caption = 'Vehicle Management';

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK1; "No. Series")
        {
            Clustered = true;
        }
    }

}