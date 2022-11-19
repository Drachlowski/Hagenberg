PROGRAM TimeConversion;


CONST
  FactorMinutesToSeconds = 60;
  FactorHoursToSeconds = 3600;
  MinimumHours = 0;
  InvalidValue = -1;


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
  IF ValidateTimeSpan(timeSpan) THEN
    TimeSpanToSeconds := timeSpan.hours * FactorHoursToSeconds + TimeSpan.minutes * FactorMinutesToSeconds + TimeSpan.seconds
  ELSE 
    TimeSpanToSeconds := InvalidValue;
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

  IF (totalSecondsForTimeSpan1 <> InvalidValue) AND (totalSecondsForTimeSpan2 <> InvalidValue) THEN BEGIN
    IF totalSecondsForTimeSpan1 >= totalSecondsForTimeSpan2 THEN
      TimeDifference := totalSecondsForTimeSpan1 - totalSecondsForTimeSpan2
    ELSE
      TimeDifference := totalSecondsForTimeSpan2 - totalSecondsForTimeSpan1;
  END
  ELSE TimeDifference := InvalidValue;

END;


PROCEDURE ReadTimeSpan (VAR outputTimeSpan : TimeSpan);
BEGIN
  Write('Hours: ');
  ReadLn(outputTimeSpan.hours);
  Write('Minutes: ');
  ReadLn(outputTimeSpan.minutes);
  Write('Seconds: ');
  ReadLn(outputTimeSpan.seconds);
  WriteLn;
END;


PROCEDURE OutputTestCase (original, backConverted : TimeSpan; seconds : INT64);
BEGIN
  WriteLn('Hours: Original: ', original.hours, ' : BackConverted: ', backConverted.hours);
  WriteLn('Minutes: Original: ', original.minutes, ' : BackConverted: ', backConverted.minutes);
  WriteLn('Seconds: Original: ', original.seconds, ' : BackConverted: ', backConverted.seconds);
  WriteLn('Total Seconds: ', seconds);
END;


VAR
  test1 : TimeSpan;
  test2 : TimeSpan;
  totalSeconds1 : INT64;
  totalSeconds2 : INT64;
  test1BackConverted : TimeSpan;
  test2BackConverted : TimeSpan;
  totalSeconds  : INT64;

BEGIN
  // Code zum Aufrufen der Prozeduren
  WriteLn('1. Timespan:');
  ReadTimeSpan(test1);
  totalSeconds1 := TimeSpanToSeconds(test1);
  test1BackConverted := SecondsToTimeSpan(totalSeconds1);

  WriteLn('2. Timespan:');
  ReadTimeSpan(test2);
  totalSeconds2 := TimeSpanToSeconds(test2);
  test2BackConverted := SecondsToTimeSpan(totalSeconds2);

  totalSeconds := TimeDifference(test1, test2);
  WriteLn;
  WriteLn('Timedifference: ', totalSeconds, ' Seconds');
  WriteLn('1. Timespan:');
  OutputTestCase(test1, test1BackConverted, totalSeconds1);
  WriteLn;
  WriteLn('2. Timespan:');
  OutputTestCase(test2, test2BackConverted, totalSeconds2);

END.