PROGRAM BC2;

FUNCTION Factorial (n : INTEGER) : INTEGER;
VAR
  i, result : INTEGER;
BEGIN
  result  := 1;
  i       := 0;

  FOR i := 1 TO n DO 
    result := result * i;
  
  Factorial := result;
END;


FUNCTION BinomialCoefficient (n, k : INTEGER) : INTEGER;
BEGIN
  BinomialCoefficient := Factorial(n) DIV (Factorial(k) * Factorial(n - k));
END;


VAR
  result: INTEGER;
BEGIN
  Write('(1 , 1) => ');
  result := BinomialCoefficient(1, 1);
  Write(result, ' - ');
  IF result = 1 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(1 , 0) => ');
  result := BinomialCoefficient(1, 0);
  Write(result, ' - ');
  IF result = 1 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(4 , 2) => ');
  result := BinomialCoefficient(4, 2);
  Write(result, ' - ');
  IF result = 6 THEN Write('OK') ELSE Write('FAILED');
  WriteLn;

  Write('(4 , 5) => ');
  result := BinomialCoefficient(4, 6);
  Write(result, ' - ');
  IF result = 0 THEN Write('OK') ELSE Write('FAILED');
  WriteLn
END
.
