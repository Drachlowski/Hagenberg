PROGRAM TimeTracker;


// Procedure in order to validate the single digits of a input
// and assemble them into an integer value
PROCEDURE validateDigits (INPUT : STRING; START_INDEX, STOP_INDEX : INTEGER; VAR result : INTEGER);

// Variables (i => index for-loop, number => as helper variable)
VAR
  i       : INTEGER;
  number  : INTEGER;

// Statements
BEGIN
  // For loop in order to validate the numbers for the hours and minutes
  FOR i := START_INDEX TO STOP_INDEX DO BEGIN

    // Get the number (based by ascii value)
    number := Ord(input[i]) - Ord('0');

    // Check if the digit is between 0 and 9
    IF number < 0 THEN EXIT;
    IF number > 9 THEN EXIT;
    
    // Calculate the result integer
    IF i = STOP_INDEX THEN result := result + number
    ELSE result := result + number * 10;
  END;

  // Add 1 to the result, because the value started with -1
  result := result + 1
END;



// Procedure to validate the time
PROCEDURE validateTime (input : STRING; VAR validInputFormat : BOOLEAN; VAR hours, minutes: INTEGER);

// Define variables for the procedure
// INPUT_LENGTH is the amount of characters of the input and the
// DELIMITER_POSITION is the index of the delimiter
VAR
  INPUT_LENGTH      : INTEGER;
  DELIMITER_POSITION: INTEGER;

// Statements
BEGIN
  // Get the length of the input and check if the input has a length of 4 or 5,
  // otherwise exit the procedure and repeate the user input
  INPUT_LENGTH := Length(input);
  IF (INPUT_LENGTH <> 4) AND (INPUT_LENGTH <> 5) THEN EXIT;

  // Set the DELIMITER_POSITION, if the length is 4, the delimiter must be at position 2
  // Otherwise the DELIMITER_POSITION is 3
  IF INPUT_LENGTH = 4 THEN DELIMITER_POSITION := 2
  ELSE DELIMITER_POSITION := 3;

  // Check if the delimiter (space or colon) is at the expected position
  // Otherwise exit the procedure
  IF (input[DELIMITER_POSITION] <> ' ') AND (input[DELIMITER_POSITION] <> ':') THEN EXIT;

  // Assemble the hours and minutes and check if the values for hours and minutes are set,
  // otherwise exit this procedure and repeat the user input reading
  validateDigits(input, 1, DELIMITER_POSITION - 1, hours);
  validateDigits(input, DELIMITER_POSITION + 1, DELIMITER_POSITION + 2, minutes);
  if (hours = -1) OR (minutes = -1) THEN EXIT();
  if (minutes > 59) THEN EXIT();

  // Set the value for validInputFormat to true
  validInputFormat := TRUE
END;



// Procedure to read the input
PROCEDURE readInput (VAR hours, minutes : INTEGER);

// Define variables for the procedure
VAR
  input           : STRING;
  validInputFormat: BOOLEAN;

BEGIN
  // Assign the value false to validInputFormat
  validInputFormat  := FALSE;

  // DO-While loop in order to read the input
  REPEAT
    // Read the user input
    WriteLn('Enter Time:');
    ReadLn(input);

    // Assign values to the variables
    // hours and minutes will be set -1 in order to check, if the digits has been
    // set correctly
    hours             := -1;
    minutes           := -1;

    // Call method in order to validate the input
    validateTime(input, validInputFormat, hours, minutes)
  UNTIL validInputFormat;
END;



// Procedure to calculate the overtime
PROCEDURE calculateOvertime (hours, minutes : INTEGER; VAR overtime : REAL);
VAR
  workingTime : REAL;
BEGIN
  workingTime := hours + (minutes / 60);
  overtime := workingTime - 8;

  if overtime > 2 THEN overtime := 2 + (overtime - 2) * 1.5;
END;


// Main

// Variables for minutes, hours and the amount of overtime
VAR
  minutes : INTEGER;
  hours   : INTEGER;
  overtime: REAL;

BEGIN
  // Read the input
  readInput(hours, minutes);

  // Calculate the overtime
  calculateOvertime(hours, minutes, overtime);
  
  // Output messages
  IF      overtime > 5 THEN WriteLn('Taegliche Hoechstarbeitszeit ueberschritten')
  ELSE IF overtime > 0 THEN WriteLn('Anspruch auf Zeitausgleich: '                  , overtime:2:2        , ' Stunden')
  ELSE IF overtime < 0 THEN WriteLn('Ausstehende Stunden: '                         , (overtime * -1):2:2 , ' Stunden')
  ELSE                      WriteLn('Kein Anspruch auf Zeitausgleich')

END.

