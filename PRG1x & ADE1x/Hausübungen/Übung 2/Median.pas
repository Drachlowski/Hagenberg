PROGRAM MedianCalc;


// Algorithm to get the Median of three integers
// It covers all combinations of integers, a sorting algorithm is not needed, always the median will be delivered.ö
FUNCTION Median (a, b, c : INTEGER): INTEGER;
BEGIN
    IF ( (b <= a) AND ( a <= c) ) OR ( (c <= a) AND (a <= b) ) THEN BEGIN
        Median := a;
        EXIT;
    END;

    IF ( (a <= b) AND (b <= c) ) OR ( (c <= b) AND (b <= a) ) THEN BEGIN
        Median := b;
        EXIT;
    END;

    Median := c;
END;

// PROCEDURE Median (a, b, c : INTEGER; VAR OUTPUT : INTEGER);
// BEGIN
//     IF ( (a <= b) AND (b <= c) ) OR ( (c <= b) AND (b <= a)) THEN
//         OUTPUT := b
//     ELSE IF ( (b <= a) AND ( a <= c) ) OR ( (c <= a) AND (a <= b) ) THEN
//         OUTPUT := a( (b <= a) AND ( a <= c) ) OR ( (c <= a) AND (a <= b) )
//     ELSE OUTPUT := c;
// END;

PROCEDURE Test (a, b, c, EXPECTATION : INTEGER);
VAR
    output : INTEGER;
BEGIN
    Write('( ', a, ', ', b, ', ', c,' ) => expect ', EXPECTATION, ' - ');
    output := Median(a, b, c);
    IF output = EXPECTATION THEN Write('OK (got ', output, ')')
    ELSE Write('FAILED (got ', output, ')');
    WriteLn;
END;

BEGIN
    WriteLn('Test 1, 2, 3 in different orders:');
    Test(1, 2, 3, 2);
    Test(3, 1, 2, 2);
    Test(2, 3, 1, 2);
    Test(3, 2, 1, 2);
    Test(1, 3, 2, 2);
    Test(2, 1, 3, 2);

    WriteLn;
    WriteLn('Test -1, -2, -3 numbers:');
    Test(-1, -2, -3, -2);
    Test(-3, -1, -2, -2);
    Test(-2, -3, -1, -2);
    Test(-3, -2, -1, -2);
    Test(-1, -3, -2, -2);
    Test(-2, -1, -3, -2);

    WriteLn;
    WriteLn('Test negative and positive numbers mixed:');
    Test(0, -10, 400, 0);
    Test(-10, -5, 2, -5);
    Test(32000, -10, -10000, 0);
    
    WriteLn;
    WriteLn('Test equal numbers:');
    Test(0, 0, 0, 0);
    Test(-10, -10, -10, -10);
    Test(500, 500, 500, 500);

    WriteLn;
    WriteLn('Test if two numbers are equal in different order:');
    Test(1, 1, 2, 1);
    Test(1, 2, 2, 2);
    Test(2, 1, 2, 2);

    WriteLn;
    WriteLn('Test a very large and small numbers');
    Test(32767, 0, 0, 0);
    Test(-32768, 0, 0, 0);
END.