PROGRAM StatefulMean;




// INTERMISSION

TYPE
  MeanState = RECORD ...


// PROCEDURE MeanState.Mean(...);
PROCEDURE Mean(VAR this; ...)
BEGIN
  this.sum := ...
END;



// Version B2+

TYPE
  meanState = RECORD
    sum : REAL;
    count : INTEGER;
  END;



// even better : Provide init method for state with OUT parameter
PROCEDURE InitMeanState (VAR state : meanState);
BEGIN
  state.sum   := 0;
  state.count := 0;
END;


// Pass STATE as _single_ REFERENCE PARAMETER - that's better
PROCEDURE Mean(VAR state: meanState; next: REAL; VAR newMean : REAL);
BEGIN
  state.sum   := state.sum    + next;
  state.count := state.count  + 1;
  newMean     := state.sum    / state.count;
END;


// PROCEDURE Foo;
// BEGIN
//   sum := 10; // Foo has also access to sum - this is really BAD!
//   count := -1;
// END;


VAR
  state : meanState;
  result: REAL;
BEGIN
  InitMeanState(state);
  Mean(state, 2, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
END.





// Version B2

TYPE
  meanState = RECORD
    sum : REAL;
    count : INTEGER;
  END;



// Pass STATE as _single_ REFERENCE PARAMETER - that's better
PROCEDURE Mean(VAR state: meanState; next: REAL; VAR newMean : REAL);
BEGIN
  state.sum   := state.sum    + next;
  state.count := state.count  + 1;
  newMean     := state.sum    / state.count;
END;


// PROCEDURE Foo;
// BEGIN
//   sum := 10; // Foo has also access to sum - this is really BAD!
//   count := -1;
// END;


VAR
  state : meanState;
  result: REAL;
BEGIN
  state.sum   := 0;
  state.count := 0;
  Mean(state, 2, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
  Mean(state, 3, result); WriteLn(result : 5 : 2);
END.


// Version B1



// Pass STATE as REFERENCE PARAMETERS
// UGLY
PROCEDURE Mean(VAR sum: REAL; VAR count: INTEGER; next: REAL; VAR newMean : REAL);
BEGIN
  sum     := sum + next;
  count   := count + 1;
  newMean := sum / count;
END;



VAR
  sum: REAL;
  count:INTEGER;
  result: REAL;
BEGIN
  sum := 0;
  count := 0;
  Mean(sum, count, 2, result); WriteLn(result);
  Mean(sum, count, 3, result); WriteLn(result);
  Mean(sum, count, 3, result); WriteLn(result);
  Mean(sum, count, 3, result); WriteLn(result);
END.




// Version A

// STATE as global variables
VAR
  sum   : REAL;
  count : INTEGER;


PROCEDURE Mean(next: REAL; VAR newMean : REAL);
// TODO where to declare sum and count so that the keep their values?
BEGIN
  sum     := sum + next;
  count   := count + 1;
  newMean := sum / count;
END;


// ..

// ..


PROCEDURE Foo;
BEGIN
  sum := 10; // Foo has also access to sum - this is really BAD!
  count := -1;
END;


VAR
  result : REAL;
BEGIN
  // INITIALIZE STATE
  sum   := 0;
  count := 0;

  Mean(2, result); WriteLn(result:5);
  Mean(3, result); WriteLn(result:5);
  Mean(3, result); WriteLn(result:5);
  Mean(3, result); WriteLn(result:5);
END.