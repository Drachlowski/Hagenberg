PROGRAM BC;

PROCEDURE Factorial (n : INTEGER; VAR fact : INTEGER);
VAR
  i : INTEGER;
BEGIN
  fact := 1;
  i := 0;
  FOR i := 1 TO n DO fact := fact * i;
END;


PROCEDURE BinomialCoefficient (n, k : INTEGER; VAR bc : INTEGER);
VAR
  nFact, kFact, nkFact : INTEGER;
BEGIN
  Factorial(n, nFact);
  Factorial(k, kFact);
  Factorial(n - k, nkFact);
  bc := nFact DIV (kFact * nkFact);
END;


VAR
  result: INTEGER;
BEGIN
  Write('(1 , 1) => ');
  BinomialCoefficient(1, 1, result);
  Write(result, ' - ');
  IF result = 1 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(1 , 0) => ');
  BinomialCoefficient(1, 0, result);
  Write(result, ' - ');
  IF result = 1 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(4 , 2) => ');
  BinomialCoefficient(4, 2, result);
  Write(result, ' - ');
  IF result = 6 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(4 , 5) => ');
  BinomialCoefficient(4, 6, result);
  Write(result, ' - ');
  IF result = 0 THEN Write('OK') ELSE Write('FAILED');
  WriteLn
END
.
