PROGRAM Pointers;


PROCEDURE Foo;
VAR
  a1: INTEGER;
BEGIN
  WriteLn(LONGINT(@a1));
END;

PROCEDURE Bar;
VAR
  b1: STRING;
BEGIN
  WriteLn(LONGINT(@b1));
  Foo;
END;

VAR
  x, y: STRING;
BEGIN
  Foo();
  WriteLn(LONGINT(@x));
  WriteLn(LONGINT(@y));
  WriteLn(LONGINT(@foo));
  Foo();
  Bar();
END.