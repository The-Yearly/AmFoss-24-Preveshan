import csv
l=[1,2,3,4]
with open("books.csv","w",newline="") as f:
    csvw=csv.writer(f,delimiter=",")
    csvw.writerow(l)
