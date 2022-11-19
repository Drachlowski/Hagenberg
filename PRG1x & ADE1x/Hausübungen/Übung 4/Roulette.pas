PROGRAM Roulette;

CONST
  numbersOfRoulette = 37;
  betOnEven         = -2;
  betOnRandom       = -1;


FUNCTION BenefitForEvenNr (bet : INTEGER) : INTEGER;
  VAR
    randomNumber  : INTEGER;
    win           : INTEGER;
    restOfDivision: INTEGER;
BEGIN
  // Get a random number between 0 and 36
  randomNumber := Random(numbersOfRoulette);

  restOfDivision := randomNumber MOD 2;
  win := 0;

  IF (randomNumber <> 0) AND (restOfDivision = 0) THEN
    win := bet * 2;
  
  BenefitForEvenNr := win;
END;


FUNCTION BenefitForLuckyNr (luckyNr, bet: INTEGER) : INTEGER;
  VAR
    win           : INTEGER;
    randomNumber  : INTEGER;
    i             : INTEGER;
BEGIN

  // Get a random number between 0 and 36
  randomNumber := Random(numbersOfRoulette);
  win := 0;

  IF luckyNr = randomNumber THEN
    win := bet * 36
  ELSE 
    win := 0;
  BenefitForLuckyNr := win;
END;


FUNCTION PlaySingleGame (luckyNrMode, bet : INTEGER) : INTEGER;
  VAR
    win : INTEGER;
    luckyNr : INTEGER;
BEGIN
  IF luckyNrMode = betOnEven THEN 
    win := BenefitForEvenNr(bet)

  ELSE BEGIN
    IF luckyNrMode = betOnRandom THEN
      luckyNr := Random(numbersOfRoulette)
    ELSE
      luckyNr := luckyNrMode;
    win := BenefitForLuckyNr(luckyNr, bet)
  END;

  PlaySingleGame := win
END;


PROCEDURE Test (luckyNrMode : INTEGER);
  VAR
    budget    : LONGINT;
    gamesLost : LONGINT;
    gamesWon  : LONGINT;
    maxMoney  : LONGINT;
    win       : INTEGER;
    luckyNr   : INTEGER;
BEGIN
  budget    := 1000;
  gamesLost := 0;
  gamesWon  := 0;
  maxMoney  := 1000;
  
  // Randomize ist echt ein leger, da es als procedure definiert ist
  Randomize();

  IF (-2 <= luckyNrMode) AND (luckyNrMode <= 36) THEN BEGIN
    WHILE (budget > 0) DO BEGIN
      budget := budget - 1;
      win := PlaySingleGame(luckyNrMode, 1);

      IF win > 0 THEN BEGIN
        budget := budget + win;
        gamesWon := gamesWon + 1;
      END
      ELSE
        gamesLost := gamesLost + 1;
    END;
  END;
  
  WriteLn('Games lost: ', gamesLost);
  WriteLn('Games won : ', gamesWon);
  WriteLn('Max. money: ', maxMoney);
END;


VAR
  i : INTEGER;
BEGIN
  WriteLn('Testcase : Bet on even numbers:');
  Test(betOnEven);
  WriteLn('-------------------------------');

  WriteLn('Testcase : Bet on random lucky numbers:');
  Test(betOnRandom);
  WriteLn('---------------------------------------');

  FOR i := 0 TO 36 DO BEGIN
    WriteLn('Testcase : Bet on lucky number ', i, ':');
    Test(i);
    WriteLn('---------------------------------------');

  END;
END.
