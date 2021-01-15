import datetime

dt = datetime.datetime.today() 
end = datetime.datetime(2022, 12, 30)
step = datetime.timedelta(days=1)
weekday = [0, 1, 2, 3, 4]
result = []

while dt < end:
    if dt.weekday() in weekday:
        result.append(dt.strftime('%Y-%m-%d'))
    else:
        pass
    dt += step

for i in result:
    print(i)

