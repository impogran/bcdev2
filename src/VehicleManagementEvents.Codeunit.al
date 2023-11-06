codeunit 50100 VehicleManagementEvents
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnAfterInitSetupTables', '', false, false)]
    local procedure MyProcedure()
    var
        VehicleManagement: Record "Vehicle Management";
    begin
        if not VehicleManagement.Get() then begin
            VehicleManagement.Init();
            VehicleManagement.Insert();
        end;
    end;
}