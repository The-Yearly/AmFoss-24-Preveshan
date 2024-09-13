# Open Docs
This Repository Is Documention Of [Micro-Blog](https://github.com/miguelgrinberg/microblog) By Miguel Grinberg A Micro-Blogging Project 
## MicroBlog
### Overview
An MicroBloggin Platform powered by python and flask
### Features
- **User Authentication:** Allows User Registration And Logins
- **Micro-Blogging:** Allows Sending of Small Messages By Users
- **User-Profile:** Provides Changing And Tweaking Of User Profiles
- **Chats:** Allows Sending Of Private Messages Between Users
- **Global Views:** Allows Other To See Your MicroBlogs Through Explore Page
- **Proper Time Line:** Post And Messages Are Top Of The Stack Based On Proper Time Of Their Posting
### Installation
  #### 1. Cloning The Repository
    git clone https://github.com/miguelgrinberg/microblog
  #### 2. Setting Up The Virtual Enviournment
  - Go To The Directory microblog
  ```bash 
  cd microblog
  ```
  - Create Virtual Environment
    ```bash
    $ python3 -m venv venv
    ```
  - Start The Virtual Environment
    - Linux/Mac
      ```bash
      $ source venv/bin/activate
      ```
    - Windows
      - In Command Prompt
        ```bash
        $ venv\Scripts\activate
        ```
      - In PowerShell
        ```bash
        $ venv\Scripts\Activate.ps1
        ```
  #### 3. Installing Dependencies
  ```bash
pip install -r requirements.txt
  ```
#### 4. Migrating The Databases
    flask db upgrade 
#### 5. Running The App
    flask run
##### 6. Go To http://localhost:5000/ to access Microblog
    
    
  
