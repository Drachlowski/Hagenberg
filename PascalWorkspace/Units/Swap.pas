PROGRAM SwapNumbers;


PROCEDURE Swap (VAR a, b : REAL);
VAR
  temp : REAL;
BEGIN
  temp  := a;
  a     := b;
  b     := temp;
END;

PROCEDURE Test (a, b : REAL);
VAR
  A_ORIGINAL : REAL;
  B_ORIGINAL : REAL;
BEGIN
  A_ORIGINAL := a;
  B_ORIGINAL := b;
  Write('(', a, ', ', b, ') => ');
  Swap(a, b);
  Write('(', a, ', ', b, ') - ');
  IF (a = B_ORIGINAL) AND (b = A_ORIGINAL) THEN Write('OK') ELSE Write('FAILED');
  WriteLn;
END;

BEGIN
  Test(1, 2);
  Test(20, -1);
  Test(10000, -12300112);
END
.