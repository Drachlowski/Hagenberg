PROGRAM Temperature;

TYPE
    WeekDays = (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
    //what if WeekDays = (Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday);
    DayTemperature = RECORD
        min, max: REAL;
    END;

// VAR
//     temperatures: ARRAY[WeekDays] OF DayTemperature;
//     i : WeekDays;

// BEGIN
//     temperatures[Monday].min := -10;
//     temperatures[Monday].max := 20;

//     FOR i := Monday TO Sunday DO BEGIN
//         WriteLn(i);
//         temperatures[i].min := -10 + 3 * Ord(i);
//         temperatures[i].max := 5 * Ord(i);
//         WriteLn(temperatures[i].min, temperatures[i].max);
//     END;
// END
// .

// iterate over whole array

VAR
    temperatures: ARRAY[WeekDays] OF DayTemperature;
    day : WeekDays;

BEGIN
    // iterate over whole array
    // FOR day in WeekDays DO WriteLn(day);
    FOR day := Low(WeekDays) TO High(Weekdays) DO WriteLn(day); // much better ! avoids "magic numbers"
END.