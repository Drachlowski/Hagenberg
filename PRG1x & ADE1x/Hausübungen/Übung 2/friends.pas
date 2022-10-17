PROGRAM Friends;


PROCEDURE DividerSum (VALUE : INTEGER);
VAR
  i, SUM : INTEGER;
BEGIN
  SUM := 0;
  FOR i := 1 TO VALUE - 1 DO BEGIN
    IF (VALUE MOD i) = 0 THEN SUM := SUM + i;
  END;
  WriteLn(SUM);
END;


BEGIN
  DividerSum(284);
  DividerSum(220);
END.