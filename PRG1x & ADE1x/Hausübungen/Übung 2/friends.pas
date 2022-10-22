PROGRAM Friends;

FUNCTION CheckIfSingleDivider (VALUE, DIVIDER : INTEGER) : BOOLEAN;
BEGIN
  IF (VALUE MOD DIVIDER) = 0 THEN EXIT(TRUE);
  EXIT(FALSE)
END;


FUNCTION GetDividerSum (VALUE : INTEGER) : INTEGER;
VAR
  sum, i : INTEGER;
BEGIN
  sum := 0;

  FOR i := 1 TO VALUE - 1 DO BEGIN
    IF CheckIfSingleDivider(VALUE, i) THEN sum := sum + i;
  END;


  EXIT(sum);
END;


// This procedure get the divider sum of a number and outputs it in the format
// Summe der echten Teiler von <Number> : 1 + <all dividers> = <DIVIDER_SUM>
PROCEDURE CheckAndOutputSingleNumber (VALUE : INTEGER; VAR DIVIDER_SUM : INTEGER);
VAR
  i : INTEGER;
BEGIN
  DIVIDER_SUM := GetDividerSum(VALUE);

  Write('Summe der echten Teiler von ', VALUE, ' : 1 ');

  FOR i := 2 TO (VALUE - 1) DO BEGIN
    IF CheckIfSingleDivider(VALUE, i) THEN Write('+ ', i, ' ');
  END;

  Write('= ', DIVIDER_SUM);
  WriteLn;
END;


// This procedure gets two values and check if they are friends
// Also special cases are implemented
PROCEDURE CheckIfNumbersAreFriends (VALUE_1, VALUE_2 : INTEGER);
VAR
  DIVIDER_SUM_1 : INTEGER;
  DIVIDER_SUM_2 : INTEGER;
BEGIN
  DIVIDER_SUM_1 := 0;
  DIVIDER_SUM_2 := 0;

  IF (VALUE_1 > 1) THEN CheckAndOutputSingleNumber(VALUE_1, DIVIDER_SUM_1)
  ELSE WriteLn('Der Wert ', VALUE_1, ' hat keine Echten Teiler!');
  IF (VALUE_2 > 1) THEN CheckAndOutputSingleNumber(VALUE_2, DIVIDER_SUM_2)
  ELSE WriteLn('Der Wert ', VALUE_2, ' hat keine Echten Teiler!');

  IF (DIVIDER_SUM_1 = 0) OR (DIVIDER_SUM_2 = 0) THEN WriteLn('Die Zahlen sind nicht befreundet!')
  ELSE IF (VALUE_1 = DIVIDER_SUM_2) OR (DIVIDER_SUM_1 = VALUE_2) THEN WriteLn('Die Zahlen sind befreundet!')
  ELSE WriteLn('Die Zahlen sind nicht befreundet');
END;


VAR
  WERT_1, WERT_2 : INTEGER;
BEGIN
  WriteLn('Erste Zahl:');
  ReadLn(WERT_1);

  WriteLn('Zweite Zahl');
  ReadLn(WERT_2);

  CheckIfNumbersAreFriends(WERT_1, WERT_2);
END
.