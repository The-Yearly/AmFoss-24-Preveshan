from typing import Final
TOKEN:Final="7201982465:AAEN9xfa3bsI_bLvLI9S7WtYYescpJxrjfk"
BOT_USERNAME:Final="@Orimi_BookieBot"
from telegram import Update
from telegram.ext import Application,CommandHandler, MessageHandler,filters,ContextTypes
async def start_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Hello! Thanks For Chatting With Me")

async def help_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    await update.message.reply_text("Help You Okay")

def handle_response(text:str)-> str:
    text.lower()
    print(text)
    if "hello" in text:
        return("hi")
    if "great" in text:
        return("good")
async def book_command(update:Update,context:ContextTypes.DEFAULT_TYPE):
    with open("books.csv", "rb") as f:
        chat_id = update.effective_chat.id
        await context.bot.send_document(chat_id,"books.csv"))
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
async def error(update:Update,context:ContextTypes.DEFAULT_TYPE):
    print(f"Update{update} caused error{context.error}")
if __name__== "__main__":
    app=Application.builder().token(TOKEN).build()
    app.add_handler(CommandHandler("start",start_command))
    app.add_handler(CommandHandler("help",help_command))
    app.add_handler(CommandHandler("book",book_command))
    app.add_handler(MessageHandler(filters.TEXT,handle_message))
    app.add_error_handler(error)
    print("starting")
    app.run_polling(poll_interval=3)

    
    
