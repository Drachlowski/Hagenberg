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
  dummy[1] := 1;
  dummy[2] := 1;
  dummy[3] := 1;
  dummy[4] := 1;

  ipAddressList^.next := CreateNode(dummy, ipAddressList);
  PrintList(ipAddressList);
END.