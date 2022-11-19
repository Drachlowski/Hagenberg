PROGRAM IntersectionCheck;

CONST
  errorCase = -1;

FUNCTION IsSorted (field: ARRAY OF INTEGER; n : INTEGER) : BOOLEAN;
  VAR
    result  : BOOLEAN;
    i       : INTEGER;
    endIndex: INTEGER;
BEGIN
  result := TRUE;

  i := Low(field);
  endIndex := Low(field) + n - 1;

  WHILE i < endIndex DO BEGIN
    IF field[i] > field[i + 1] THEN BEGIN
      result := FALSE;
      i := High(field);
    END;

    Inc(i);
  END;  
  IsSorted := result;
END;


PROCEDURE AppendIntersectionItem (value : INTEGER; VAR field: ARRAY OF INTEGER; VAR n : INTEGER);
  VAR
    startIndex  : INTEGER;
    i           : INTEGER;
  
BEGIN
  startIndex := Low(field);
  i := startIndex + n;
  IF i > High(field) THEN
    n := errorCase
  ELSE BEGIN
    field[i] := value;
    Inc(n);
  END;
END;


PROCEDURE ComputeIntersetcion (
      a1 : ARRAY OF INTEGER;      n1: INTEGER;
      a2 : ARRAY OF INTEGER;      n2: INTEGER;
  VAR a3 : ARRAY OF INTEGER; VAR  n3: INTEGER
);
  VAR
    i, j          : INTEGER;
    currentValue  : INTEGER;
    endA1         : INTEGER;
    endA2         : INTEGER;
  
BEGIN
  i := Low(a1);
  endA1 := Low(a1) + n1 - 1;

  endA2 := Low(a2) + n2 - 1;

  WHILE i <= endA1 DO BEGIN
    j := Low(a2);
    WHILE j <= endA2 DO BEGIN
    
      currentValue := a1[i];
      IF a1[i] = a2[j] THEN AppendIntersectionItem(currentValue, a3, n3);
      IF n3 = errorCase THEN BEGIN
        i := endA1 + 1;
        j := endA2 + 1;
      END;
      Inc(j);
    END;

    Inc(i);
  END;
END;


PROCEDURE Intersect (
      a1 : ARRAY OF INTEGER;      n1: INTEGER;
      a2 : ARRAY OF INTEGER;      n2: INTEGER;
  VAR a3 : ARRAY OF INTEGER; VAR  n3: INTEGER
);
  VAR
    validA1Length       : BOOLEAN;
    validA2Length       : BOOLEAN;
BEGIN
  n3 := 0;
  validA1Length := n1 <= Length(a1);
  validA2Length := n2 <= Length(a2);

  IF IsSorted(a1, n1) AND IsSorted(a2, n2) AND validA1Length AND validA2Length THEN BEGIN
    ComputeIntersetcion(a1, n1, a2, n2, a3, n3);
  END ELSE IF (n1 = 0) OR (n2 = 0) THEN
    n3 := 0
  ELSE 
    n3 := errorCase;
END;




PROCEDURE PrintField (field : ARRAY OF INTEGER; n : INTEGER);
  VAR
    i : INTEGER;
    firstIndex : INTEGER;

BEGIN
  WriteLn('n: ', n);

  WriteLn('Items in field:');
  IF n > 0 THEN BEGIN
    firstIndex := Low(field);
    Write(field[firstIndex]);
    FOR i := firstIndex + 1 TO firstIndex + n - 1 DO
      Write(', ', field[i]);
  END;
  WriteLn;
END;



PROCEDURE Test;
  VAR
    // a<number of items>
    a0 : ARRAY OF INTEGER;
    a2 : ARRAY [1..2] OF INTEGER;
    a3 : ARRAY [1..3] OF INTEGER;
    a4 : ARRAY [1..4] OF INTEGER;
    a5 : ARRAY [1..5] OF INTEGER;
    a6 : ARRAY [1..6] OF INTEGER;
    n : INTEGER;

BEGIN
  a6[1] := 1;
  a6[2] := 2;
  a6[3] := 3;
  a6[4] := 5;
  a6[5] := 8;
  a6[6] := 13;

  
  a5[1] := 1;
  a5[2] := 3;
  a5[3] := 5;
  a5[4] := 7;
  a5[5] := 9;

  WriteLn('Normaler Testfall (Länge von a3 = 3)');
  Intersect(a6, 6, a5, 5, a3, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a3, n);
  WriteLn('---------------------------------------------');
  WriteLn('Überlauf von A3');
  Intersect(a6, 6, a5, 5, a2, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a2, n);
  WriteLn('---------------------------------------------');
  a6[3] := 11;
  WriteLn('Unsortiertes A1');
  Intersect(a6, 6, a5, 5, a3, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a3, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  a5[3] := 100;
  WriteLn('Unsortiertes A1 und A2');
  Intersect(a6, 6, a5, 5, a3, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a3, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  a6[3] := 3;
  WriteLn('Unsortiertes A2');
  Intersect(a6, 6, a5, 5, a3, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a3, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  a5[3] := 5;
  a6[3] := 3;
  WriteLn('Array A3 ohne items');
  Intersect(a6, 6, a5, 5, a0, n);
  WriteLn('A1:');
  PrintField(a6, 6);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a0, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  WriteLn('Array A1 ohne items');
  Intersect(a4, 0, a5, 5, a0, n);
  WriteLn('A1:');
  PrintField(a4, 0);
  WriteLn;
  WriteLn('A2:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('Result:');
  PrintField(a0, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  WriteLn('Array A2 ohne items');
  Intersect(a5, 5, a4, 0, a0, n);
  WriteLn('A1:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('A2:');
  PrintField(a4, 0);
  WriteLn;
  WriteLn('Result:');
  PrintField(a0, n);
  WriteLn;
  WriteLn('---------------------------------------------');
  WriteLn('Array A1 und A2 ohne items');
  Intersect(a4, 0, a4, 0, a0, n);
  WriteLn('A1:');
  PrintField(a5, 5);
  WriteLn;
  WriteLn('A2:');
  PrintField(a4, 0);
  WriteLn;
  WriteLn('Result:');
  PrintField(a0, n);
  WriteLn;
  WriteLn('---------------------------------------------');


END;


BEGIN
  Test();
END.