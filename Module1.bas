Attribute VB_Name = "Module1"
Sub VBA()
   Dim cell As Range
    Dim selectedRange As Range

    Set selectedRange = Application.Selection

    Dim rowCounter As Integer
    Dim columnCounter As Integer
    Dim totalColumns As Integer
    Dim currentColumnWidth As Integer

    totalColumns = selectedRange.Columns.Count

    Dim columnWidth(50) As String

    For i = 0 To totalColumns
        columnWidth(i) = 0
    Next i
    
    '///
    '/// go through range to calculate maximum lengths of each column
    '///

   
    For Each Row In selectedRange.Rows

        columnCounter = 0

        For Each cell In Row.Cells

            currentColumnWidth = Len(cell.Value)

            If (currentColumnWidth > columnWidth(columnCounter)) Then

                columnWidth(columnCounter) = currentColumnWidth

            End If

            columnCounter = columnCounter + 1
            

        Next cell

    Next Row
    
    
    Dim currentLine As String
    
    rowCounter = 0
    For Each Row In selectedRange.Rows

        columnCounter = 0

        currentLine = "|"

        For Each cell In Row.Cells

            currentColumnWidth = columnWidth(columnCounter)
            Dim extraSpaces As Integer
            
            '///
            '/// if statement that creates a temporary variable to store and then checks to see if its a hyperlink.
            '///
           
           
           
            '///Calls temporary variable
            tempCell = cell.Value
            '///if statement that checks if there is a "!" in the cell. If there is one then it excludes it from printing out.
            If cell.Hyperlinks.Count > 0 And Not InStr(1, cell.Value, "!") > 0 And InStr(1, cell.Value, " ") > 0 Then
            tempCell2 = Replace(cell.Hyperlinks(1).Address, " ", "%20")
            cell.Value = "[" + cell.Value + "]" + "(" + tempCell2 + ")"
            ElseIf cell.Hyperlinks.Count > 0 And Not InStr(1, cell.Value, "!") > 0 Then
            '///Here it links to the hyperlink address
            cell.Value = "[" + cell.Value + "]" + "(" + cell.Hyperlinks(1).Address + ")"
            End If
            '///This is a simple if statement that checks to see if the cell is bolded. Using markdown language "__" makes the cell bold in markdown.
            If cell.Font.Bold = True Then
            cell.Value = "__" + cell.Value + "__"
            End If

            currentLine = currentLine & " "
            currentLine = currentLine & cell.Value
            extraSpaces = currentColumnWidth - Len(cell.Value)

            For j = 0 To extraSpaces

                currentLine = currentLine & " "

            Next j

            currentLine = currentLine & " |"

            columnCounter = columnCounter + 1
            

        Next cell

        Debug.Print currentLine

        If (rowCounter = 0) Then

            currentLine = "|"
            columnCounter = 0

            For j = 0 To (totalColumns - 1)

                currentLine = currentLine
                currentColumnWidth = columnWidth(columnCounter)
                currentLine = currentLine & "-"

                For k = 0 To currentColumnWidth

                    currentLine = currentLine & "-"
                Next k

                currentLine = currentLine & "-|"
                columnCounter = columnCounter + 1

            Next j
    
            Debug.Print currentLine
        End If

        rowCounter = rowCounter + 1

    Next Row
    




End Sub
