import click
import requests
import imdb
import os
import time
from bs4 import BeautifulSoup
from subs_file_hash_size import *
ia = imdb.IMDb()
script_dir = os.path.dirname(os.path.abspath(__file__))
path=os.path.join(script_dir,"Movie")
@click.command()
@click.option('--l',help="--l Enter The Language You Need",default="-1")
@click.option("--b",help="--b Enter The Batch File Location Path",default=path)
@click.option("--o",help="--o Enter Output Folder",default="")
@click.option("--s",help="--s Filter By Size",is_flag=True)
@click.option("--h",help="--h Search By Hash",is_flag=True)
def start(l,b,o,h,s):
    path=b
    try:
        movie_folder = os.listdir(path)
        if movie_folder==[]:
            click.secho("The Following Folder Is Empty",fg="red",bold=True)
        for movie in movie_folder:
            click.secho(movie,fg="blue")
            click.secho("...",blink=True,fg="yellow")
            movie_name=movie.split(".")
            name=movie_name[0]
            search=ia.search_movie(name)
            if search==[]:
                click.secho("Could Not Find Movie",fg="red",bold=True)
                click.echo("\n")
                continue
            id=search[0].movieID
            path=os.path.join(b,movie)
            returnedhash, filesize = hash_size_File_url(path)
            if h==False:
                if s==False:
                    url=f"https://www.opensubtitles.org/en/search/sublanguageid-all/imdbid-{id}"
                else:
                    url=f"https://www.opensubtitles.org/en/search2/sublanguageid-all/moviebytesize-{filesize}/imdbid-{id}"
            else:
                hash_url=f"https://www.opensubtitles.org/en/search2/sublanguageid-all/moviebytesize-{filesize}/moviename-{returnedhash}"
                click.secho(f"Hash Id:{returnedhash}",fg="magenta")
                try:
                    result_hash=requests.get(hash_url)
                    doc_hash=BeautifulSoup(result_hash.text,"html.parser")
                    next_hash_page=doc_hash.find(["a"],string=">>")
                    table_hash=doc_hash.find(id="search_results")
                    links_hash=table_hash.findAll(["tr"],onclick=True)
                    hashes={}
                    page_no=1
                    click.secho("Connecting...",fg="yellow",blink=True)
                    while True:
                        with click.progressbar(links_hash,label=click.style(f"Searching Movies For Hash In Page {page_no}",fg="yellow",bold=True),fill_char=click.style('█', fg='yellow')) as bar:
                            for g in bar:
                                a_hash_tag=g.find(["a"])
                                hash_link=a_hash_tag.get("href")
                                hash_td=g.findAll(["td"])
                                hash_a=hash_td[1].find(["a"])
                                hasht=hash_a.get("title")
                                hashl=hasht.split("-")
                                hash=hashl[-1]
                                hash=hash.strip()
                                hash=hash.lower()
                                hashes[hash]=hash_link
                                time.sleep(0.03)
                        if next_hash_page==None:
                            break
                        else:
                            page_no+=1
                            result_hash=requests.get(url)
                            doc_hash=BeautifulSoup(result_hash.text,"html.parser")
                            next_hash_page=doc_hash.find(["a"],string=">>")
                            if next_hash_page==None:
                                break
                            next_hash=next_hash_page.get("href")
                            hash_url="https://www.opensubtitles.org"+next_hash
                            table_hash=doc.find(id="search_results")
                            links_hash=table.findAll(["tr"],onclick=True)
                    click.echo("\n")
                    for ha in hashes:
                        click.secho(ha,fg="blue")
                        time.sleep(0.02)
                    click.echo("\n")
                    click.secho("These Are The Following Result",fg="magenta")
                    click.echo("\n")
                    try:
                        seleted_movie=click.prompt(click.style("Enter Your Desired Movie",fg="cyan"))
                        seleted_movie=seleted_movie.lower()
                        url="https://www.opensubtitles.org"+hashes[seleted_movie]
                    except KeyError:
                        click.echo("\n")
                        click.secho("Invalid Entry",fg="red",bold=True)
                        click.echo("\n")
                        break
                except AttributeError:
                    click.echo("\n")
                    click.secho("Counld Not Find Subtitles Based On Hash",fg="red",bold=True)
                    click.echo("\n")
                    continue
            try:    
                result=requests.get(url)
                doc=BeautifulSoup(result.text,"html.parser")
                next_page=doc.find(["a"],string=">>")
                table=doc.find(id="search_results")
                links=table.findAll(["tr"],onclick=True)
                languages={}
                page_no=1
                click.echo("\n")
                click.secho("Connecting...",blink=True,fg="yellow")
                while True:
                    with click.progressbar(links,label=click.style(f"Loading Subtitles from Page {page_no}",fg="yellow",bold=True),fill_char=click.style('█', fg='yellow')) as bar:
                        for g in bar:
                            a_tag=g.find(["a"])
                            link=a_tag.get("href")
                            td=g.findAll(["td"])
                            lang_td=g.findAll(["td"])
                            lang_a=lang_td[1].find(["a"])
                            language=lang_a.get("title")
                            language=language.lower()
                            if language not in languages:
                                languages[language]=link
                            time.sleep(0.03)
                    if next_page==None:
                        break
                    else:
                        page_no+=1
                        result=requests.get(url)
                        doc=BeautifulSoup(result.text,"html.parser")
                        next_page=doc.find(["a"],string=">>")
                        if next_page==None:
                            break
                        next=next_page.get("href")
                        url="https://www.opensubtitles.org"+next
                        table=doc.find(id="search_results")
                        links=table.findAll(["tr"],onclick=True)
                click.echo("\n") 
                if l=="-1":
                    for g in languages:
                        click.secho(g,bold=True,fg="blue")
                        time.sleep(0.02)
                    click.echo("\n")
                    click.secho("These Are The Following Languages",fg="magenta")
                    click.echo("\n")
                    seleted_language=click.prompt(click.style("Enter Your Desired Language",fg='cyan'))
                else:
                    seleted_language=l
                seleted_language=seleted_language.lower()
                download_page="https://www.opensubtitles.org"+languages[seleted_language]
                download_sub(download_page,o)
            except AttributeError:
                if h==True:
                    try:
                        download_sub(url,o)#incase i get download link rather than link to table of subtitles
                    except Exception as e:
                        click.echo("\n")
                        click.secho("No Record Found",fg="red",blink=True)
                        click.echo("\n")
            except KeyError:
                click.echo("\n")
                click.secho("Subtitles Not Available For This Language",fg="red",bold=True)
                click.echo("\n")
    except FileNotFoundError:
        click.echo("\n")
        click.secho("Could Not Find File",fg="red",bold=True)
        click.echo("\n")
def download_sub(download_link,o):
    session=requests.Session()
    headers={'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko)'' Chrome/92.0.4515.131 Safari/537.36'}
    response=session.get(download_link, headers=headers)
    finalresult=BeautifulSoup(response.text, "html.parser")
    download_button=finalresult.find("a", {"id": "bt-dwl-bt"})
    download_path=download_button["href"]
    download_url=f"https://www.opensubtitles.org{download_path}"
    download_response=session.get(download_url, headers=headers)
    filename=download_response.headers.get("Content-Disposition")
    content_length= int(download_response.headers.get("content-length", 0))
    if 'filename=' in filename:
        filename=filename.split('filename=')[1].strip('"')
    if o!="":
        filename=os.path.join(o,filename)
    else:
        a=os.path.join(script_dir,"Output")
        filename=os.path.join(a,filename)
    with open(filename, 'wb') as file:
        with click.progressbar(length=content_length, label=click.style('Downloading',fg="green",bold=True),fill_char=click.style('█', fg='green')) as bar:
            for j in download_response.iter_content(chunk_size=1024):
                if j:
                    file.write(j)
                    bar.update(len(j))
                    time.sleep(0.02)
        click.echo("\n")
        click.secho(f"Subtitle downloaded successfully and saved as '{filename}'.",fg="green",bold=True)
        click.echo("\n")
start()