PROGRAM DeleteSubstringProgram;

CONST
  stringStartIndex = 1;

FUNCTION SubstringIsNextIndexes (s, substr : STRING; startPosition : INTEGER) : BOOLEAN;
  VAR
    i        : INTEGER;
    result   : BOOLEAN;
    position : INTEGER;
BEGIN
  result := FALSE;

  i := stringStartIndex;

  WHILE i <= Length(substr) DO BEGIN
    position := startPosition + i - 1;

    IF (s[position] <> substr[i]) OR (position > Length(s)) 
      THEN BEGIN
        i := Length(substr) + 1;
        result := FALSE;
      END;

    IF (i = Length(substr)) AND (s[position] = substr[i]) 
      THEN result := TRUE;
    
    Inc(i);
  END;

  SubstringIsNextIndexes := result;
END;



FUNCTION DeleteSubstring (s, substr : STRING) : STRING;
  VAR
    newString         : STRING;
    i                 : INTEGER;
BEGIN
  newString         := '';

  i := stringStartIndex;

  WHILE i <= Length(s) DO BEGIN
    IF (SubstringIsNextIndexes(s, substr, i)) THEN i := i + Length(substr) - 1
    ELSE newString := newString + s[i];

    Inc(i);
  END;
  
  DeleteSubstring := newString;
END;


PROCEDURE Test (inputString, substringToDelete, expectedOutput : STRING);
  VAR
    result : STRING;
BEGIN
  WriteLn('Input     : ', '"', inputString, '"');
  WriteLn('Substring : ', '"', substringToDelete, '"');
  WriteLn('Expected  : ', '"', expectedOutput, '"');
  result := DeleteSubstring(inputString, substringToDelete);
  WriteLn('Output    : ', '"', result, '"');
  if result = expectedOutput THEN
    WriteLn('Status    : OK')
  ELSE
    WriteLn('Status    : FAILED');
  WriteLn('--------------------------------------')

END;



VAR
  i : INTEGER;
  longString : STRING;
BEGIN
  Test('helloWorldHelloHello', 'llo', 'heWorldHeHe');
  Test('helloWorldHelloHell', 'llo', 'heWorldHeHell');
  Test('helloWorldHelloHello', '', 'helloWorldHelloHello');
  Test('Hallo, ich bin Mario!', 'Mario', 'Hallo, ich bin !');
  Test('Hallo, ich bin Mario!', ' ', 'Hallo,ichbinMario!');
  Test('Hallo, ich bin Mario!', ',', 'Hallo ich bin Mario!');
  Test('Hallo, ich bin Mario!', ' Mario!', 'Hallo, ich bin');
  Test('Zwischen zwei Zwetschgenzweigen schweben zwei zwitschernde Schwalben.',
        'zw',
        'Zwischen ei Zwetschgeneigen schweben ei itschernde Schwalben.');
  Test('', 'llo', '');
  Test('', '', '');
  Test(' ', ' ', '');

  longString := '';
  WriteLn('Very long string:');
  FOR i := 0 TO 100 DO longString := longString + 'Zwischen zwei Zwetschgenzweigen schweben zwei zwitschernde Schwalben.' + 'Hello';
  WriteLn('Length: ', Length(longString));
  WriteLn('String: ', longString);
  WriteLn('Output: ');
  WriteLn(DeleteSubstring(longString, 'Hello'));
END.