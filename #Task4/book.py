import requests
import csv
api="AIzaSyDSmOyU8osKNYRRCbdHOY6Vz69jBZ5-sfg"
def searchbook(query,api):
    url="https://www.googleapis.com/books/v1/volumes"
    params={
        'q': query,
        "key":api,
        'maxResults': 40
        }
    re=requests.get(url,params=params)
    if re.status_code==200:
        return(re.json())
    else:
        re.raise_for_status()
query=input()
def display_books(books_json):
    print(len(books_json))
    l=[]
    for item in books_json.get('items', []):
        volume_info = item.get('volumeInfo', {})
        title = volume_info.get('title', 'No title available')
        authors = volume_info.get('authors', 'No authors available')
        published_date = volume_info.get('publishedDate', 'No date available')
        description = volume_info.get('description', 'No description available')
        genre=volume_info.get("categories","no genre")
        preview=volume_info.get("previewLink","none")
        r=[title,authors,genre,published_date,description,preview]
        l.append(r)
    with open("books.csv","w",newline="") as f:
        csvw=csv.writer(f,delimiter=",")
        for g in l:
            print(g)
            csvw.writerow(g)
    print("donr")
results=searchbook(query,api)
display_books(results)

    

