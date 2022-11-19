PROGRAM IntersectionCheck;

CONST
  errorCase = -1;

FUNCTION IsSorted (field: ARRAY OF INTEGER) : BOOLEAN;
  VAR
    result  : BOOLEAN;
    i       : INTEGER;
BEGIN
  result := TRUE;

  FOR i:= Low(field) TO High(field) - 1 DO
    IF field[i] > field[i + 1] THEN BEGIN
      result := FALSE;
      i := High(field);
    END;
  
  IsSorted := result;
END;


PROCEDURE PushIntersectionItem (value : INTEGER; VAR field: ARRAY OF INTEGER; VAR n : INTEGER);
VAR
  startIndex : INTEGER;
  i         : INTEGER;
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


PROCEDURE ComputeIntersetcion (a1, a2 : ARRAY OF INTEGER; VAR a3 : ARRAY OF INTEGER; VAR n3 : INTEGER);
VAR
  i, j : INTEGER;
  currentValue : INTEGER;

BEGIN
  FOR i := Low(a1) TO High(a1) DO BEGIN
    FOR j := Low(a2) TO High(a2) DO BEGIN
      currentValue := a1[i];
      IF a1[i] = a2[j] THEN PushIntersectionItem(currentValue, a3, n3);
      IF n3 = errorCase THEN BEGIN
        i := High(a1) + 1;
        j := High(a2) + 1;
      END;
    END;
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
  i, j                : INTEGER;
  currentValue        : INTEGER;
BEGIN
  n3 := 0;
  validA1Length := Length(a1) = n1;
  validA2Length := Length(a2) = n2;

  IF (IsSorted(a1)) AND (IsSorted(a2)) AND validA1Length AND validA2Length THEN BEGIN
    ComputeIntersetcion(a1, a2, a3, n3);
  END
  ELSE 
    n3 := errorCase;
END;


VAR
  a1 : ARRAY [1..6] OF INTEGER;
  a2 : ARRAY [1..5] OF INTEGER;
  a3 : ARRAY [1..3] OF INTEGER;
  n3 : INTEGER;
  i   : INTEGER;
BEGIN
  n3 := 0;
  a1[1] := 1;
  a1[2] := 2;
  a1[3] := 3;
  a1[4] := 5;
  a1[5] := 8;
  a1[6] := 13;
  // a1[3] := 10;

  a2[1] := 1;
  a2[2] := 3;
  a2[3] := 5;
  a2[4] := 7;
  a2[5] := 9;
  Intersect(a1, 6, a2, 5, a3, n3);
  WriteLn(n3);
  FOR i := Low(a3) TO Low(a3) + n3 - 1 DO
    Write(a3[i], ', ');
END.