PROGRAM MatrixCalculator;

TYPE
  MatrixLength = 1..3;
  MatrixItem = ARRAY[MatrixLength] OF REAL;
  Matrix = ARRAY[MatrixLength] OF MatrixItem;


FUNCTION TurnMatrix (inputMatrix : Matrix) : Matrix;
  VAR
    outputMatrix : Matrix;
    i, j : INTEGER;
BEGIN
  FOR i := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
    FOR j := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
      outputMatrix[j, i] := inputMatrix[i, j];
    END;
  END;
  TurnMatrix := outputMatrix;
END;


FUNCTION GetScalarProduct (matrixRowA, matrixRowB : MatrixItem) : REAL;
  VAR
    sum : REAL;
    column : INTEGER;
BEGIN
  sum := 0;

  FOR column := Low(MatrixLength) TO High(MatrixLength) DO
    sum := sum + matrixRowA[column] * matrixRowB[column];
  
  GetScalarProduct := sum;
END;


FUNCTION MultiplyMatrix (matrixA, matrixB : Matrix) : Matrix;
  VAR
    turnedMatrixB : Matrix;
    outputMatrix : Matrix;
    row, column : INTEGER;
    sum : REAL;
BEGIN
  turnedMatrixB := TurnMatrix(matrixB);
  FOR row := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
    FOR column := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
      outputMatrix[row, column] := GetScalarProduct(matrixA[row], turnedMatrixB[column]);
    END;
  END;
  MultiplyMatrix := outputMatrix;
END;


PROCEDURE ReadMatrix (VAR outputMatrix : Matrix);
  VAR
    row, column : INTEGER;
BEGIN
  FOR row := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
    WriteLn('Enter values for row ', row, ':');
    FOR column := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
      Write('Value for column ', column, ': ');
      ReadLn(outputMatrix[row, column]);
    END;
    WriteLn;
  END;
END;

PROCEDURE PrintMatrix (matrix : Matrix);
VAR
  i, j : INTEGER;
BEGIN
  FOR i := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
    FOR j := Low(MatrixLength) TO High(MatrixLength) DO BEGIN
      Write(matrix[i, j] :8:2, ' ');
    END;
    WriteLn;
  END;
END;


VAR 
  a, b, c : Matrix;
BEGIN
  WriteLn('Values for Matrix A: ');
  ReadMatrix(a);
  WriteLn;
  WriteLn('Values for Matrix B: ');
  ReadMatrix(b);
  c := MultiplyMatrix(a, b);
  PrintMatrix(c);
END.