PROGRAM DataTypes;


FUNCTION Sum (arr : ARRAY OF REAL): REAL;
VAR
  result : REAL;
  i : LONGINT;
BEGIN
  result := 0;
  FOR i := Low(arr) TO High(arr) DO // Low(arr) is always 0 when "arr" is open array parameters
    result := result + arr[i];

  Sum := result;
END;

VAR
  arr: ARRAY[1..10] OF REAL;
  arr2: ARRAY[20..50] OF REAL;
  arr3: ARRAY[CHAR] OF REAL;
  arr4: ARRAY[(Foo, Bar, Baz)] OF REAL;
  arr5: ARRAY[(Foo, Bar, Baz)] OF BYTE;
BEGIN
  // TODO IMPLEMENT
  WriteLn(Sum(arr), Sum(arr2), Sum(arr3), Sum(arr4));
  // WriteLn(Sum(arr5)) doesn't work arr 5 is no array of real
END.

















TYPE
  RealArray = ARRAY[1..10] OF REAL;
  LargerRealArray = ARRAY[1..20] OF REAL;
  EvenLargerRealArray = ARRAY[CHAR] OF REAL;

FUNCTION Sum (arr : RealArray): REAL;
VAR
  result : REAL;
  i : 1..10;
BEGIN
  result := 0;
  FOR i := Low(arr) TO High(arr) DO
    result := result + arr[i];

  Sum := result;
END;

VAR
  arr : RealArray;
  arr2 : LargerRealArray;
BEGIN
  WriteLn(Sum(arr));
  WriteLn(Sum(arr2));
END.























VAR
  s : STRING;
BEGIN
  s:= 'This is a really long string with quite some characters to test strings in Pascal.';
  WriteLn(Length(s));
  WriteLn(s[0]);
END.















// 1. every "] OF ARRAY [" can be replaced by ", "
// 2. every "][" can be replaced by ", "
// this changes nothing ;)





TYPE
  OneToFour   = 1..4;
  LetterAToE  = 'a'..'e';

VAR
  arr2d: ARRAY[OneToFour, LetterAToE] OF REAL; // "two dimensional" array (not really...)
  arr3d: ARRAY[OneToFour, LetterAToE, BYTE] OF REAL; // "three dimensional" array (not really...)
  i : OneToFour;
  j : LetterAToE;
BEGIN
  arr2d[2, 'c'] := 3.6;
  arr3d[2, 'c', 200] := 200;

  FOR i := Low(i) TO High(i) DO 
    FOR j := Low(j) TO High(j) DO
      arr2d[i, j] := 0;
END.










TYPE
  NumberArray = ARRAY['a'..'z'] OF REAL;

PROCEDURE PrintNumbers (arr: NumberArray; count : INTEGER);
VAR
  i: INTEGER;
  i2: 'a'..'z';
BEGIN
  i:= 1;
  i2 := Low(arr);
  IF i > Length(arr);
    count := Length(arr);
  WHILE i <= count DO BEGIN
    WriteLn(arr[i2]);
    Inc(i2);
    Inc(i);
  END; 
END;
BEGIN
  // ...
END.



VAR
  arr : ARRAY[11..15] OF BYTE;
  i : 11..15;
  // i : INTEGER; // possible, probably not reallybetter
BEGIN
  FOR i:= Low(arr) TO High(arr) DO
    arr[i] := 42;
  FOR i:= Low(arr) TO High(arr) DO
    WriteLn(arr[i]);
  
  // Let's do it right - always (1) check / ensure and INDICES are IN RANGE
  ReadLn(i);
  IF (Low(arr) <= i) AND (i <= High(arr)) THEN
    WriteLn(arr[i])
  ELSE WriteLn('Nice try!');
END.





VAR
  arr : ARRAY[11..15] OF BYTE;
  i : 11..15;
  // i : INTEGER; // possible, probably not reallybetter
BEGIN
  FOR i:= Low(arr) TO High(arr) DO
    arr[i] := 42;
  FOR i:= Low(arr) TO High(arr) DO
    WriteLn(arr[i]);
  
  // Let's get nasty >:D
  // Don't try this at home
  ReadLn(i);
  WriteLn(arr[i]); // WTF?
END.
































// Brilliant
FUNCTION MinutesForSeconds (seconds : INTEGER): REAL;
CONST
  SecondsPerMinute = 60;
BEGIN
  MinutesForSeconds := seconds / SecondsPerMinute;
END;


// GOOD
FUNCTION MinutesForSeconds (seconds : INTEGER): REAL;
BEGIN
  MinutesForSeconds := seconds / 60;
END;



TYPE
  Month: (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
  Date : RECORD
    day: 1..31;
    month: Month;
    year: INTEGER;
  END;

VAR
  today : Date;
BEGIN
  today.day := 22;
  today.month := Oct;
  today.year := 2022;
END.