PROGRAM Lib;

TYPE
  AuthorNodePtr = ^AuthorNode;
  AuthorNode = RECORD
    next: AuthorNodePtr;
    name: STRING;
  END;
  BookNodePtr = ^BookNode;
  BookNode = RECORD
    prev, next: BookNodePtr;
    title: STRING;
    authors: AuthorNodePtr;
  END;

VAR
  bookIndex: BookNodePtr;


FUNCTION CreateBookNode (title : STRING): BookNodePtr;
  VAR
    bookNode : BookNodePtr;
BEGIN
  New(bookNode);
  bookNode^.title := title;
  CreateBookNode := bookNode;
END;


FUNCTION CreateAuthorNode (name : STRING) : AuthorNodePtr;
  VAR
    authorNode : AuthorNodePtr;
  BEGIN
    New(authorNode);
    authorNode^.name := name;
    authorNode^.next := NIL;
    CreateAuthorNode := authorNode;
  END;


PROCEDURE InitializeBooks;
BEGIN
  bookIndex := CreateBookNode('Dummy');
  bookIndex^.next := bookIndex;
  bookIndex^.prev := bookIndex;
END;


PROCEDURE AddAuthor (VAR authorNode : AuthorNodePtr; author : STRING);
  VAR
    node : AuthorNodePtr;
    previousNode : AuthorNodePtr;
    newAuthorNode : AuthorNodePtr;
  BEGIN
    node := authorNode;

    WHILE (node <> NIL) AND (LowerCase(node^.name) < LowerCase(author)) DO BEGIN
      previousNode := node;
      node := node^.next;
    END;
    
    newAuthorNode := CreateAuthorNode(author);

    IF node = authorNode THEN BEGIN
      authorNode := newAuthorNode;
      authorNode^.next := node;
    END
    ELSE IF node = NIL THEN BEGIN
      previousNode^.next := newAuthorNode;
    END
    ELSE BEGIN
      newAuthorNode^.next := previousNode^.next;
      previousNode^.next := newAuthorNode;
    END;
    

  END;


PROCEDURE InsertBook (title : STRING; author : STRING);
  VAR
    node : BookNodePtr;
    newBookNode : BookNodePtr;
BEGIN
  node := bookIndex^.next;

  WHILE (node <> bookIndex) AND (node^.title <> title) AND (LowerCase(node^.title) <= LowerCase(title)) DO BEGIN
    node := node^.next;
  END; 

  IF (node <> bookIndex) AND (node^.title = title) THEN AddAuthor(node^.authors, author)
  ELSE BEGIN
    newBookNode := CreateBookNode(title);
    newBookNode^.authors := CreateAuthorNode(author);

    newBookNode^.prev := node^.prev;
    node^.prev := newBookNode;
    newBookNode^.prev^.next := newBookNode;
    newBookNode^.next := node;
  END;
END;


FUNCTION NrOfBooksOf (author : STRING) : INTEGER;
  VAR
    bookNode : BookNodePtr;
    authorNode: AuthorNodePtr;
    count : INTEGER;
  BEGIN
    count := 0;
    bookNode := bookIndex^.next;

    WHILE bookNode <> bookIndex DO BEGIN
      authorNode := bookNode^.authors;

      WHILE (authorNode <> NIL) AND (authorNode^.name <> author) DO BEGIN
        authorNode := authorNode^.next;
      END;

      IF (authorNode <> NIL) AND (authorNode^.name = author) THEN Inc(count);
      bookNode := bookNode^.next;
    END;

    NrOfBooksOf := count;
  END;


PROCEDURE PrintAuthors (authorNode : AuthorNodePtr);
  VAR
    node : AuthorNodePtr;
  BEGIN
    node := authorNode;

    WHILE node <> NIL DO BEGIN
      WriteLn(node^.name);
      node := node^.next;
    END;
  END;


PROCEDURE PrintAll;
  VAR
    node : BookNodePtr;
  BEGIN
    node := bookIndex^.next;

    WriteLn('BEGIN All Books:');
    WriteLn('----------');
    WHILE node <> bookIndex DO BEGIN
      WriteLn(node^.title);
      PrintAuthors(node^.authors);
      WriteLn('----------');
      node := node^.next;
    END;
    WriteLn('END All Books');
    WriteLn('-------------');
  END;


PROCEDURE PrintAuthorsOf (title : STRING);
  VAR
    node : BookNodePtr;
  BEGIN
    node := bookIndex^.next;

    WHILE (node <> bookIndex) AND (node^.title <> title) DO BEGIN
      node := node^.next;
    END;

    IF (node <> bookIndex) THEN BEGIN
      WriteLn('Authors of book ', title);
      PrintAuthors(node^.authors);
    END
    ELSE WriteLn('There is no book with the title ', title)
  END;


PROCEDURE DisposeBook (book : BookNodePtr);
  VAR
    authorNode : AuthorNodePtr;
    nextAuthor : AuthorNodePtr;
  BEGIN
    authorNode := book^.authors;

    WHILE authorNode <> NIL DO BEGIN
      nextAuthor := authorNode^.next;
      Dispose(authorNode);
      authorNode := nextAuthor;
    END;

    Dispose(book);
  END;


PROCEDURE DisposeAll;
  VAR
    node : BookNodePtr;
  
  BEGIN
    node := bookIndex^.next;
    WHILE node <> bookIndex DO BEGIN
      
    END;
  END;

VAR TEST : BookNodePtr;
BEGIN
  // WriteLn('Hello' < 'gello')
  InitializeBooks;
  PrintAll;
  InsertBook('hello', 'Andreas');
  InsertBook('hello', 'Neu');
  InsertBook('It''s me', 'Andreas');
  InsertBook('allo', 'Andreas');
  InsertBook('beringer', 'neu');
  InsertBook('Beringer', 'Andreas');
  InsertBook('Beringer', 'Hellow');
  WriteLn(NrOfBooksOf('Andreas'));
  PrintAll;
  PrintAuthorsOf('Beringer');
  PrintAuthorsOf('Vinegar');
END.