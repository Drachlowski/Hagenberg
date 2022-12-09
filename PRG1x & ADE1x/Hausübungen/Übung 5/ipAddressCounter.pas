PROGRAM IPAddressCounter;

CONST
  max = 4;

TYPE
  IPAddress = ARRAY [1..max] OF BYTE;
  IPAddrNodePtr = ^IPAddrNode;
  IPAddrNode = RECORD
    next : IPAddrNodePtr;
    addr: IPAddress;
    n: INTEGER; (* Number of accesses from addr *)
  END;


PROCEDURE PrintList (list : IPAddrNodePtr);
  VAR
    node : IPAddrNodePtr;
  BEGIN
    node := list^.next;
    WHILE node <> list DO BEGIN
      WriteLn('Address: ', node^.addr[1], '.', node^.addr[2], '.', node^.addr[3], '.', node^.addr[4]);
      WriteLn('n: ', node^.n);
      node := node^.next;
    END;
  END;

FUNCTION CreateNode (value : IPAddress; next : IPAddrNodePtr) : IPAddrNodePtr;
  VAR
    node : IPAddrNodePtr;
  BEGIN
    New(node);
    node^.next := next;
    node^.n := 1;
    node^.addr := value;
    CreateNode := node;
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

PROCEDURE ReadIP (VAR list : IPAddrNodePtr);
  VAR
    input : STRING;
    currentIP : IPAddress;
  BEGIN

    REPEAT
      ReadLn(input);
      
      IF (input <> '') and (IPIsValid(input)) THEN BEGIN
        currentIP := ComputeIPAddress(input);
        list^.next := CreateNode(currentIP, list^.next);
        // AppendToList(list, currentIP);
      END;
    UNTIL (input = '');

  END;



PROCEDURE InitializeList (VAR ipAddressList : IPAddrNodePtr);
  BEGIN
    New(ipAddressList);
    ipAddressList^.next := ipAddressList;
  END;


VAR
  dummy : IPAddress;
  ipAddressList : IPAddrNodePtr;
BEGIN
  InitializeList(ipAddressList);
  ReadIP(ipAddressList);
  PrintList(ipAddressList);
END.