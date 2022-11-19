UNIT MeanUnit;

// Öffentlicher Teil
INTERFACE

// Stateful algorithm that computes the arithmetic mean value of a series of numbers.
// IN   next    : The next vale to add to the series of numbers.
// OUT  newMean : The new current mean value after next has been added.
// Works for positive and negative numbers. Must only be used on sunny days... ;)
// EXAMPLE: 1, 2, 3, 4
// next := 1; newMean := 1
// next := 2; newMean := 1.5
// next := 3; newMean := 2
// next := 4; newMean := 2.5
PROCEDURE Mean (next : REAL; VAR newMean : REAL);



// Resets the state of the mean algorithm.
// This allows to start with a fresh series of mean values.
PROCEDURE ResetMean;



// Implementierungsteil, nur von HelloUnit.pas sichtbar
IMPLEMENTATION

VAR
  sum   : REAL;
  count : INTEGER;


PROCEDURE Mean (next : REAL; VAR newMean : REAL);
BEGIN
  sum     := sum    + next;
  count   := count  + 1;
  newMean := sum    / count;
END;


PROCEDURE ResetMean;
BEGIN
  sum := 0;
  count := 0;
END;


// Not visible outside of the unit
PROCEDURE Foo;
BEGIN
END;


BEGIN
  ResetMean;
END.