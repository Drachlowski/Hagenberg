PROGRAM CreateBarChart;

CONST
  PipeCharacter   = '|';
  EmptyString     = '';
  TrailBegin      = '+';
  MinusCharacter  = '-';
  SpaceCharacter  = ' ';


TYPE
  BarValue      = 1..10;
  BarRange      = 1..40;
  BarChartData  = ARRAY[BarRange] OF BarValue;


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



PROCEDURE BarChart (ch: CHAR; n : INTEGER; data : BarChartData);
  VAR
    i : INTEGER;
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



PROCEDURE ReadData (VAR character : CHAR; VAR amountOfData : INTEGER; VAR data : BarChartData);
  VAR
    i : INTEGER;
    inputData : INTEGER;
BEGIN
  Write('ch: ');
  Read(character);

  Write('n: ');
  ReadLn(amountOfData);

  IF (Low(BarRange) <= amountOfData) AND (amountOfData <= High(BarRange)) THEN BEGIN
    i := Low(data);

    WHILE (i <= amountOfData) DO BEGIN
      Write('data item ', i, ': ');
      ReadLn(inputData);
      IF (inputData < Low(BarValue)) OR (High(BarValue) < inputData) 
        THEN amountOfData := 0
      ELSE 
        data[i] := inputData;
      Inc(i);
    END;
  END 
  ELSE amountOfData := 0;

END;


VAR
  data, test : BarChartData;
  character : CHAR;
  amountOfData : INTEGER;
BEGIN
  ReadData(character, amountOfData, data);
  WriteLn;
  IF amountOfData = 0 THEN WriteLn('Invalid input!')
  ELSE BarChart(character, amountOfData, data);
END.