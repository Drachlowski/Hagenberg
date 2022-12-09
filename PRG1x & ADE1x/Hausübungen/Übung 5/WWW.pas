PROGRAM WWW;

CONST
  max = 4;

TYPE
  Match = (Start, Lower, Equal, Greater);
  IPAddress = ARRAY [1..max] OF BYTE;
  IPAddrNodePtr = ^IPAddrNode;
  IPAddrNode = RECORD
    next : IPAddrNodePtr;
    addr: IPAddress;
    n: INTEGER; (* Number of accesses from addr *)
  END;
  IPAddressList = IPAddrNodePtr;


PROCEDURE WriteList (list : IPAddressList);
VAR
  n : IPAddrNodePtr;
BEGIN
  n := list;

  WHILE n <> nil DO BEGIN
    WriteLn('Address: ', n^.addr[1], '.', n^.addr[2], '.', n^.addr[3], '.', n^.addr[4]);
    WriteLn('n: ', n^.n);
    n := n^.next;
  END;
END;


FUNCTION IPIsValid (input : STRING) : BOOLEAN;
  VAR 
    i : INTEGER;
    dotCount, digitCount : INTEGER;
    result : BOOLEAN;
    value : INTEGER;
  BEGIN
    dotCount := 0;
    digitCount := 0;
    result := TRUE;

    i := 1;

    WHILE i < Length(input) + 1 DO BEGIN
      IF input[i] = '.' THEN BEGIN
        Inc(dotCount);
        digitCount := 0;
      END
      ELSE BEGIN
        value := Ord(input[i]) - Ord('0');
        IF (value < 0) OR (value > 9) OR (digitCount > 3) THEN BEGIN
          result := FALSE;
          i := Length(input);
        END
        ELSE Inc(digitCount);
      END;
      Inc(i);
    END;
    
    IF (dotCount = 3) AND (result) THEN result := TRUE
    ELSE result := FALSE;

    IPIsValid := result;
  END;


FUNCTION ComputeIPAddress (input : STRING) : IPAddress;
  VAR
    output : IPAddress;
    position, i : INTEGER;
    value : BYTE;
    currentCharacter : CHAR;
  BEGIN
    position := 1;
    value := 0;

    FOR i := 1 TO Length(input) DO BEGIN
      currentCharacter := input[i];
      IF (currentCharacter = '.') THEN BEGIN
        output[position] := value;
        value := 0;
        Inc(position);
      END ELSE BEGIN
        value := value * 10;
        value := value + Ord(input[i]) - Ord('0');

        IF Length(input) = i THEN
          output[position] := value;
      END;
    END;

    ComputeIPAddress := output;
  END;


FUNCTION CreateNewItem (value : IPAddress; next : IPAddrNodePtr) : IPAddrNodePtr;
  VAR
    node : IPAddrNodePtr;
    i : INTEGER;
  BEGIN
    New(node);
    node^.next := next;
    node^.n := 1;
    FOR i := 1 TO max DO
      node^.addr[i] := value[i];
    CreateNewItem := node;
  END;


FUNCTION IPInNode (nodeAddr, inputAddr : IPAddress) : Match;
  VAR
    i : INTEGER;
    nodeMatch : Match;
  BEGIN
    i := 1;

    WHILE i < max DO BEGIN
      IF nodeAddr[i] = inputAddr[i] THEN BEGIN
        nodeMatch := Equal;
        Inc(i);
      END
      ELSE BEGIN
        IF nodeAddr[i] < inputAddr[i] THEN
          nodeMatch := Greater
        ELSE
          nodeMatch := Lower;
        i := max;
      END;
    END;

    IPInNode := nodeMatch;
  END;



PROCEDURE AppendToList (VAR list : IPAddressList; value : IPAddress);
  VAR
    n, before : IPAddrNodePtr;
    node : IPAddrNodePtr;
    overwritten : BOOLEAN;
    nodeMatch : Match;
BEGIN
  n := list;
  before := list;
  overwritten := FALSE;
  nodeMatch := Start;

  // WHILE (n <> nil) AND (overwritten = FALSE) AND (nodeMatch <> Lower) DO BEGIN
  //   nodeMatch := IPInNode(n^.addr, value);

  //   WriteLn(nodeMatch);
  //   IF nodeMatch = Equal THEN BEGIN
  //     n^.n := n^.n + 1;
  //     overwritten := TRUE;
  //   END ELSE n := n^.next;
  // END;

  // IF overwritten = FALSE THEN BEGIN
  //   IF list = nil THEN
  //     list := CreateNewItem(value , nil)
  //   ELSE BEGIN
  //     node := CreateNewItem(value, list);
  //     list := node;
  //   END;
  // END;
  // WriteList(list);
  // WriteLn('____________________________')
  WHILE (n <> nil) AND (overwritten = FALSE) AND (nodeMatch <> Lower) DO BEGIN
    nodeMatch := IPInNode(n^.addr, value);
    IF nodeMatch = Equal THEN BEGIN
      n^.n := n^.n + 1;
      overwritten := TRUE;
    END 
    ELSE IF nodeMatch = Greater THEN BEGIN
      before := n;
      n := n^.next;
    END;
  END;
  IF overwritten = FALSE THEN BEGIN
    IF list = nil THEN
      list := CreateNewItem(value , nil)
    ELSE IF nodeMatch = Lower THEN
      BEGIN
        IF (before = list) AND (n = list) THEN BEGIN
          WriteLn('HER');
          node := CreateNewItem(value, list);
          list := node;
        END
        ELSE BEGIN
          node := CreateNewItem(value, n);
          before^.next := node;
        END;
      END
    ELSE BEGIN
      IF (before = list) AND (nodeMatch = Lower) THEN BEGIN
        node := CreateNewItem(value, list);
        list := node;
      END ELSE IF (before = list) AND (nodeMatch = Greater) THEN BEGIN
        node := CreateNewItem(value, list^.next);
        list^.next := node;
      END
      ELSE BEGIN
        node := CreateNewItem(value, before^.next);
        before^.next := node;
      END;
    END;
  END;
END;


PROCEDURE ReadIP (VAR list : IPAddressList);
VAR
  input : STRING;
  currentIP : IPAddress;
BEGIN

  REPEAT
    ReadLn(input);
    
    IF (input <> '') and (IPIsValid(input)) THEN BEGIN
      currentIP := ComputeIPAddress(input);
      WriteLn(input);
      AppendToList(list, currentIP);
      WriteLn('_________');
    END;
  UNTIL (input = '');

END;


FUNCTION GetLength (list : IPAddressList) : INTEGER;
VAR
  n : IPAddrNodePtr;
  counter : INTEGER;
BEGIN
  counter := 0;
  n := list;
  WHILE (n <> nil) DO BEGIN
    Inc(counter);
    n := n^.next;
  END;

  GetLength := counter;
END;


// PROCEDURE SortList (VAR list : IPAddressList);
//   VAR
//     n : IPAddrNode;
//     largestBefore, largest : IPAddrNode;
//     i : INTEGER;
// BEGIN
//   nBefore := list;
//   nCurrent := list;
//   largestBefore := list;
//   largest := list;
//   FOR i := 1 TO GetLength(list) DO BEGIN
//     n := list;
//     nCurrent := list;
//     WHILE n <> nil DO BEGIN

//     END;
//   END;
// END;


VAR
  ip: IPAddressList;
BEGIN

  ip := nil;
  ReadIP(ip);
  WriteList(ip);
  // SortList(ip);
  WriteLn('LEN:', GetLength(ip));

END.