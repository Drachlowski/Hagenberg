PROGRAM Mean;

PROCEDURE Output( total, numbers : INTEGER );
VAR
  average: REAL;
BEGIN
  IF numbers > 0
  THEN average := total / numbers
  ELSE average := 0;
  WriteLn(average);
END;

VAR
  total : INTEGER;
  numbers: INTEGER;
  value: INTEGER;
BEGIN
  numbers := 0;
  total := 0;
  ReadLn(value);

  WHILE value > 0
  DO BEGIN
    total := total + value;
    numbers := numbers + 1;
    ReadLn(value)
  END;

  Output(total, numbers);
END
.
