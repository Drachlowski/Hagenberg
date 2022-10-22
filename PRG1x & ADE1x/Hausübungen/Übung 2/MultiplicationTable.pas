PROGRAM MultiplicationTable;

PROCEDURE DisplayTable (COUNT_ROWS, COUNT_COLUMNS : INTEGER);
VAR
  i, j: INTEGER;
BEGIN

  // Iterate over each row and write the result in every Column
  // In the write, the operator : 4 has been applied, that means
  // that the result is a string with 4 characters. (20 * 20 = 400)
  FOR i := 1 TO COUNT_ROWS DO BEGIN
    FOR j := 1 TO COUNT_COLUMNS DO BEGIN
      Write(i*j : 4);
    END;
    WriteLn;
  END;
  
  WriteLn;

END;

// n = Count of rows
// m = Count of columns
VAR
  n, m : INTEGER;
BEGIN
  n := 0;
  m := 0;

  REPEAT
    // At the inital run, the prozedure DisplayTable won't run,
    // because n and m are set to 0
    IF (1 <= n) AND (n <= 20) AND (1 <= m) AND (m <= 20) THEN DisplayTable(n, m)
    ELSE IF (n <> 0) THEN BEGIN 
      WriteLn('Ungueltige Eingabe!');
      WriteLn;
    END;

    WriteLn('Anzahl der Zeilen:');
    ReadLn(n);

    IF (1 <= n) AND (n <= 20) THEN BEGIN
      WriteLn('Anzahl der Spalten:');
      ReadLn(m);
    END

  UNTIL (n = 0);

END.