PROGRAM TimeConversion;


CONST
  FactorMinutesToSeconds = 60;
  FactorHoursToSeconds = 3600;
  MinimumHours = 0;


TYPE
  MinutesAndHoursSpan = 0..59;
  TimeSpan = RECORD
    hours : LONGWORD;
    minutes: BYTE;
    seconds: BYTE;
  END;

FUNCTION ValidateTimeSpan (timeSpan : TimeSpan): BOOLEAN;
VAR
  validInput : BOOLEAN;
BEGIN

  validInput := TRUE;

  IF (timeSpan.seconds < Low(MinutesAndHoursSpan)) OR (timeSpan.seconds > High(MinutesAndHoursSpan))
    THEN validInput := FALSE;

  IF (timeSpan.minutes < Low(MinutesAndHoursSpan)) OR (timeSpan.minutes > High(MinutesAndHoursSpan))
    THEN validInput := FALSE;

  IF timeSpan.hours < MinimumHours
    THEN validInput := FALSE;

  ValidateTimeSpan := validInput;
  
END;


FUNCTION TimeSpanToSeconds (timeSpan : TimeSpan) : INT64;
BEGIN
  TimeSpanToSeconds := timeSpan.hours * FactorHoursToSeconds + TimeSpan.minutes * FactorMinutesToSeconds + TimeSpan.seconds;
END;


FUNCTION SecondsToTimeSpan (seconds : INT64) : TimeSpan;
VAR
  outputTimeSpan : TimeSpan;
  remainingSeconds : INT64;
BEGIN
  remainingSeconds := seconds;

  outputTimeSpan.hours  := remainingSeconds DIV FactorHoursToSeconds;
  remainingSeconds      := remainingSeconds MOD FactorHoursToSeconds;

  outputTimeSpan.minutes  := remainingSeconds DIV FactorMinutesToSeconds;
  remainingSeconds        := remainingSeconds MOD FactorMinutesToSeconds;

  outputTimeSpan.seconds  := remainingSeconds;

  SecondsToTimeSpan := outputTimeSpan;
END;

FUNCTION TimeDifference (timeSpan1, timeSpan2 : TimeSpan) : INT64;
VAR
  totalSecondsForTimeSpan1 : INT64;
  totalSecondsForTimeSpan2 : INT64;
BEGIN
  totalSecondsForTimeSpan1 := TimeSpanToSeconds(timeSpan1);
  totalSecondsForTimeSpan2 := TimeSpanToSeconds(timeSpan2);

  IF totalSecondsForTimeSpan1 >= totalSecondsForTimeSpan2 THEN
    TimeDifference := totalSecondsForTimeSpan1 - totalSecondsForTimeSpan2
  ELSE
    TimeDifference := totalSecondsForTimeSpan2 - totalSecondsForTimeSpan1;
END;





VAR
  test : TimeSpan;
  test1 : TimeSpan;
  totalSeconds : INT64;

BEGIN

  test.hours := 10;
  test.minutes := 1;
  test.seconds := 59;
  test1.hours := 10;
  test1.minutes := 2;
  test1.seconds := 5;

  WriteLn(TimeDifference(test, test1))
END.