PROGRAM MeanTest;
USES MeanUnit;

VAR
  result : REAL;
BEGIN

  MeanUnit.Mean(2, result); WriteLn(result:5);
  MeanUnit.Mean(3, result); WriteLn(result:5);
  MeanUnit.Mean(3, result); WriteLn(result:5);
  MeanUnit.Mean(3, result); WriteLn(result:5);
  MeanUnit.ResetMean;
  MeanUnit.Mean(1, result); WriteLn(result:5);
  MeanUnit.Mean(3, result); WriteLn(result:5);
END.