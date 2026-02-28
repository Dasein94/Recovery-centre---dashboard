VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Private Sub Worksheet_Activate()

ActiveSheet.PivotTables("Total attendance").PivotCache.Refresh

ActiveSheet.PivotTables("Monthly attendance").PivotCache.Refresh

ActiveSheet.PivotTables("Substance group").PivotCache.Refresh

ActiveSheet.PivotTables("Attendance CJS").PivotCache.Refresh

End Sub

