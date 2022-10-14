
TEMPLATE = '''
### {BEISPIEL}

### {BUCHUNG}

----

'''

while True:
    with open('Wirtschaft.md', 'a+') as FILE:

        print("Beispiel:")
        BEISPIEL = input()
        if BEISPIEL == '': break
        print("Buchung:")
        BUCHUNG = input()

        OUTPUT = TEMPLATE.format(BEISPIEL = BEISPIEL, BUCHUNG = BUCHUNG)

        FILE.write(OUTPUT)

        print(f'Added {OUTPUT}\n\n')