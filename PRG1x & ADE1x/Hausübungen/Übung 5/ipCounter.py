
import pandas as pd
import ipaddress

DF = pd.DataFrame(columns=['ip'])


def create_dataframe (FILE_LINES : list) -> pd.DataFrame:

    DF = pd.DataFrame(columns=['ip'])

    for ITEM in FILE_LINES:
        CACHE = ITEM.replace('\n', '')
        try: 
            SERIES = pd.Series({"ip": ipaddress.ip_address(CACHE)})
            DF.loc[len(DF)] = SERIES
        except: pass
    
    return DF

with open('ip3.txt') as FILE_INPUT:
    ITEMS = FILE_INPUT.readlines()

    DF = create_dataframe(ITEMS)

DF = DF.groupby(['ip'])['ip'].count().reset_index(name='count')
DF = DF.sort_values(by=['ip'], ascending = True)
print(DF)