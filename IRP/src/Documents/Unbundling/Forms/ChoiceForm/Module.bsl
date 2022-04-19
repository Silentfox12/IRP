#Region FormEvents

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)
	DocUnbundlingServer.OnCreateAtServerChoiceForm(ThisObject, Cancel, StandardProcessing);
EndProcedure

#EndRegion

#Region Commands

&AtClient
Procedure GeneratedFormCommandActionByName(Command)
	SelectedRows = Items.List.SelectedRows;
	ExternalCommandsClient.GeneratedListChoiceFormCommandActionByName(SelectedRows, ThisObject, Command.Name);
	GeneratedFormCommandActionByNameServer(Command.Name, SelectedRows);
EndProcedure

&AtServer
Procedure GeneratedFormCommandActionByNameServer(CommandName, SelectedRows)
	ExternalCommandsServer.GeneratedListChoiceFormCommandActionByName(SelectedRows, ThisObject, CommandName);
EndProcedure

#EndRegion