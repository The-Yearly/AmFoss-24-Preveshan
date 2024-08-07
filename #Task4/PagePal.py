from telegram import Update
from telegram.ext import Application,CommandHandler, MessageHandler,filters,ContextTypes
from typing import Final
import requests
import csv
TOKEN:Final="7201982465:AAEN9xfa3bsI_bLvLI9S7WtYYescpJxrjfk"
BOT_USERNAME:Final="@Orimi_BookieBot"
mode=0
def searchbook(query):
    url="https://www.googleapis.com/books/v1/volumes"
    params={
        'q': f"subject:{query}",
        "key":"AIzaSyDSmOyU8osKNYRRCbdHOY6Vz69jBZ5-sfg",
        'maxResults': 40
        }
    re=requests.get(url,params=params)
    if re.status_code==200:
        return(re.json())
    else:
        re.raise_for_status()
async def start_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Hello! Thanks For Chatting With Me")

async def help_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("These Are The Following Command /book")

def makecsv(books_json):
    l=[["Title","Author","Genre","Published Date","Descriprion","Preveiw Link"]]
    with open("books.csv","w",newline="", encoding="utf-8") as f:
        csvw=csv.writer(f,delimiter=",")
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
        for g in l:
            csvw.writerow(g)
def handle_response(text:str)-> str:
    text.lower()
    global m
    print(text)
    if m==1:
        result=searchbook(text)
        makecsv(result)
        return(text)
    if "hello" in text:
        return("hi")
    if "great" in text:
        return("good")
async def handle_message(update:Update,context:ContextTypes.DEFAULT_TYPE):
    message_type:str=update.message.chat.type
    text:str=update.message.text
    print(f'User ({update.message.chat.id}) in {message_type}:"{text}"')
    if message_type=="group":
        if BOT_USERNAME in text:
            new_text:str=text.replace(BOT_USERNAME,"").strip()
            response:str=handle_response(new_text)
        else:
            return
    else:
        response:str=handle_response(text)
    print("Bot:",response)
    await update.message.reply_text(response)
    chat_id = update.effective_chat.id
    await context.bot.send_document(chat_id,"books.csv")
async def error(update:Update,context:ContextTypes.DEFAULT_TYPE):
    print(f"Update{update} caused error{context.error}")
async def book_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    global m    
    m=1
    await update.message.reply_text("Please tell Me what genre you are looking for")
    
if __name__== "__main__":
    app=Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start",start_command))
    app.add_handler(CommandHandler("help",help_command))
    app.add_handler(CommandHandler("book",book_command))
    app.add_handler(MessageHandler(filters.TEXT,handle_message))
    app.add_error_handler(error)
    app.run_polling(poll_interval=3)
    print("starting")

    
