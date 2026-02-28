Attribute VB_Name = "Module1"
Sub Rearranged()
Attribute Rearranged.VB_ProcData.VB_Invoke_Func = "R\n14"
'
' Rearranged Macro
'
' Keyboard Shortcut: Ctrl+Shift+R
'
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Add( _
        Range("Table1[[#All],[Name]]"), xlSortOnCellColor, xlAscending, , xlSortNormal) _
        .SortOnValue.Color = RGB(255, 199, 206)
    With ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Add _
        Key:=Range("Table1[[#All],[Name]]"), SortOn:=xlSortOnValues, Order:= _
        xlAscending, DataOption:=xlSortNormal
    With ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
    ActiveSheet.ListObjects("Table1").Range.AutoFilter Field:=4, Criteria1:=RGB _
        (255, 199, 206), Operator:=xlFilterCellColor
End Sub
Sub Clients()
Attribute Clients.VB_ProcData.VB_Invoke_Func = "C\n14"
'
' Clients Macro
'
' Keyboard Shortcut: Ctrl+Shift+C
'
    ActiveSheet.ListObjects("Table1").Range.AutoFilter Field:=4
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Clear
    ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort.SortFields.Add _
        Key:=Range("Table1[[#All],[Date of appointment]]"), SortOn:=xlSortOnValues _
        , Order:=xlAscending, DataOption:=xlSortNormal
    With ActiveWorkbook.Worksheets("Table").ListObjects("Table1").Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
End Sub
