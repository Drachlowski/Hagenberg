// Beispiele aus der Angabe

1. Timespan:
Hours: 0
Minutes: 0
Seconds: 0

2. Timespan:
Hours: 4
Minutes: 13
Seconds: 23


Timedifference: 15203 Seconds
1. Timespan:
Hours: Original: 0 : BackConverted: 0
Minutes: Original: 0 : BackConverted: 0
Seconds: Original: 0 : BackConverted: 0
Total Seconds: 0

2. Timespan:
Hours: Original: 4 : BackConverted: 4
Minutes: Original: 13 : BackConverted: 13
Seconds: Original: 23 : BackConverted: 23
Total Seconds: 15203



// Beweis, dass die Timespans auch getauscht werden können
Timedifference: 15203 Seconds
1. Timespan:
Hours: Original: 4 : BackConverted: 4
Minutes: Original: 13 : BackConverted: 13
Seconds: Original: 23 : BackConverted: 23
Total Seconds: 15203

2. Timespan:
Hours: Original: 0 : BackConverted: 0
Minutes: Original: 0 : BackConverted: 0
Seconds: Original: 0 : BackConverted: 0
Total Seconds: 0



// Ungültige Eingaben
1. Timespan:
Hours: 1
Minutes: 62
Seconds: 17

2. Timespan:
Hours: 1
Minutes: 17
Seconds: 62


Timedifference: -1 Seconds
1. Timespan:
Hours: Original: 1 : BackConverted: 0
Minutes: Original: 62 : BackConverted: 0
Seconds: Original: 17 : BackConverted: 255
Total Seconds: -1

2. Timespan:
Hours: Original: 1 : BackConverted: 0
Minutes: Original: 17 : BackConverted: 0
Seconds: Original: 62 : BackConverted: 255
Total Seconds: -1


// Ungültige Stunden
1. Timespan:
Hours: -1
Runtime error 106 at $004017FA
  $004017FA
  $00401AC0
  $004086E7

// Ungültige Eingabe (weil character)
1. Timespan:
Hours: A
Runtime error 106 at $004017FA
  $004017FA
  $00401AC0
  $004086E7

// Stunden werden zu groß
// Fehler, weil überlauf
1. Timespan:
Hours: 4294967295
Minutes: 59
Seconds: 59

2. Timespan:
Hours: 4294967296
Runtime error 106 at $004017FA
  $004017FA
  $00401B2C
  $004086E7


// Bei der Konvertierung von Sekunden zu TimeSpan kann es ebenfalls dazu kommen, dass die Stunden überlaufen, da Sekunden vom Typ INT64 ist und Hours von Typ LONGWORD