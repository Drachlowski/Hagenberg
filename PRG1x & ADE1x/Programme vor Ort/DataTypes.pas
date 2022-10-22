PROGRAM DataTypes;

TYPE
  Month: (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
  Date : RECORD
    day: 1..31;
    month: Month;
    year: INTEGER;
  END;

VAR
  today : Date;
BEGIN
  today.day := 22;
  today.month := Oct;
  today.year := 2022;
END.