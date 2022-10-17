PROGRAM MultiplicationTable;

PROCEDURE DisplayTable (ANZAHL_ZEILEN, ANZAHL_SPALTEN : INTEGER);
VAR
  i, j: INTEGER;
BEGIN
  FOR i := 1 TO ANZAHL_ZEILEN DO BEGIN
    FOR j := 1 TO ANZAHL_SPALTEN DO BEGIN
      Write(i*j:4);
    END;
    WriteLn;
  END;

END;

BEGIN
  DisplayTable(20, 20);
END.