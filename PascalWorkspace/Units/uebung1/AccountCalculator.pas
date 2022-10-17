PROGRAM AccountCalculator;

// Creating variables
// input        => User input
// revenue      => Positive input (more money)
// expenditure  => Negative input (less money)
// sum          => SUm of revenue + expenditure
VAR
  input: INTEGER;
  revenue : INTEGER;
  expenditure : INTEGER;
  sum: INTEGER;

// Statements
BEGIN
  // Set revenue and expenditure to 0
  revenue := 0;
  expenditure := 0;

  // Read the user input
  ReadLn(input);

  // Run the loop until the user input is 0
  // If the input is greater than 0, sum the input to the revenue
  // Else sum the input to the expenditure
  // At the last step read the next user input
  WHILE input <> 0 DO BEGIN
    IF input > 0 THEN revenue := revenue + input
    ELSE expenditure := expenditure + input;

    ReadLn(input); 
  END;

  // Calculate the sum
  // In this case, you need to add the expenditure to the revenue
  // because the expenditure has a negative value
  sum := revenue + expenditure;

  // Output the data
  WriteLn('Einnahmen: ', revenue);
  WriteLn('Ausgaben: ', expenditure);
  WriteLn('Gesamt: ', sum)
END
.