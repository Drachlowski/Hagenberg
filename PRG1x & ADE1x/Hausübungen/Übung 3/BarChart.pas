PROGRAM CreateBarChart;

CONST
  MaximumBars = 40;
  BarItemWidth = 2;
  PipeCharacter = '|';
  EmptyString = '';
  TrailBegin = '+';
  MinusCharacter = '-'
  SpaceCharacter = ' ';

TYPE
  BarValue = 1..10;
  BarChartData = ARRAY[1..MaximumBars] OF BarValue;


// amountOfData represents n
FUNCTION LineIsRequired (lineNumber, amountOfData : INTEGER; data : BarChartData) : BOOLEAN;
VAR
  isRequired  : BOOLEAN;
  i           : INTEGER;

BEGIN
  isRequired := FALSE;

  FOR i := Low(data) TO amountOfData DO BEGIN
    IF data[i] >= lineNumber THEN isRequired := TRUE;
  END;

  LineIsRequired := isRequired;
END;



PROCEDURE PrintChartLine (lineNumber, amountOfData : INTEGER; data : BarChartData; character : CHAR; yIndexWidth, barItemWidth : INTEGER);
VAR
  i : INTEGER;

BEGIN
  Write(lineNumber : yIndexWidth, PipeCharacter);

  FOR i := Low(data) TO amountOfData DO BEGIN
    IF data[i] >= lineNumber THEN Write(character : barItemWidth)
    ELSE Write(EmptyString : barItemWidth);
  END;

  WriteLn;
END;



PROCEDURE PrintChartTail (amountOfData : INTEGER; data : BarChartData; yIndexWidth, barItemWidth : INTEGER);
VAR
  columnsToPrint, i : INTEGER;

BEGIN
  columnsToPrint := amountOfData * barItemWidth;
  Write(EmptyString : yIndexWidth, TrailBegin);

  FOR i := Low(data) TO columnsToPrint DO Write(MinusCharacter);
  WriteLn;

  Write(EmptyString : yIndexWidth, SpaceCharacter);
  FOR i := Low(data) TO amountOfData DO Write(i : barItemWidth);
END;



PROCEDURE BarChar (ch: CHAR; n : INTEGER; data : BarChartData);
VAR
  i : INTEGER;
  j : INTEGER;
  lineRequired : BOOLEAN;
  yIndexWidth : INTEGER;
  barItemWidth : INTEGER;
BEGIN
  yIndexWidth := 1;

  IF n < 10 THEN barItemWidth := 2
  ELSE barItemWidth := 3;

  FOR i:= High(BarValue) DOWNTO Low(BarValue) DO BEGIN
    lineRequired := LineIsRequired(i, n, data);
    IF (lineRequired = TRUE) AND (i = High(BarValue)) THEN yIndexWidth := 2;
    IF lineRequired THEN PrintChartLine(i, n, data, ch, yIndexWidth, barItemWidth) ;
  END;
  PrintChartTail(n, data, yIndexWidth, barItemWidth);
END;

VAR
  test : BarChartData;
BEGIN
  test[1] := 1;
  test[2] := 2;
  test[3] := 3;
  test[4] := 4;
  test[5] := 5;
  test[6] := 6;
  test[7] := 7;
  test[8] := 8;
  test[9] := 9;
  test[10] := 10;
  test[11] := 8;
  BarChar('a', 11, test);
END.