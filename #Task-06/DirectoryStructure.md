# Directory Structure
```
.
├── Dockerfile
├── LICENSE
├── Procfile
├── README.md
├── Vagrantfile
├── app
│   ├── __init__.py
│   ├── api
│   │   ├── __init__.py
│   │   ├── auth.py
│   │   ├── errors.py
│   │   ├── tokens.py
│   │   └── users.py
│   ├── auth
│   │   ├── __init__.py
│   │   ├── email.py
│   │   ├── forms.py
│   │   └── routes.py
│   ├── cli.py
│   ├── email.py
│   ├── errors
│   │   ├── __init__.py
│   │   └── handlers.py
│   ├── main
│   │   ├── __init__.py
│   │   ├── forms.py
│   │   └── routes.py
│   ├── models.py
│   ├── search.py
│   ├── static
│   │   └── loading.gif
│   ├── tasks.py
│   ├── templates
│   │   ├── _post.html
│   │   ├── auth
│   │   │   ├── login.html
│   │   │   ├── register.html
│   │   │   ├── reset_password.html
│   │   │   └── reset_password_request.html
│   │   ├── base.html
│   │   ├── bootstrap_wtf.html
│   │   ├── edit_profile.html
│   │   ├── email
│   │   │   ├── export_posts.html
│   │   │   ├── export_posts.txt
│   │   │   ├── reset_password.html
│   │   │   └── reset_password.txt
│   │   ├── errors
│   │   │   ├── 404.html
│   │   │   └── 500.html
│   │   ├── index.html
│   │   ├── messages.html
│   │   ├── search.html
│   │   ├── send_message.html
│   │   ├── user.html
│   │   └── user_popup.html
│   ├── translate.py
│   └── translations
│       └── es
│           └── LC_MESSAGES
│               └── messages.po
├── babel.cfg
├── boot.sh
├── config.py
├── deployment
│   ├── nginx
│   │   └── microblog
│   └── supervisor
│       ├── microblog-tasks.conf
│       └── microblog.conf
├── microblog.py
├── migrations
│   ├── README
│   ├── alembic.ini
│   ├── env.py
│   ├── script.py.mako
│   └── versions
│       ├── 2b017edaa91f_add_language_to_posts.py
│       ├── 37f06a334dbf_new_fields_in_user_model.py
│       ├── 780739b227a7_posts_table.py
│       ├── 834b1a697901_user_tokens.py
│       ├── ae346256b650_followers.py
│       ├── c81bac34faab_tasks.py
│       ├── d049de007ccf_private_messages.py
│       ├── e517276bb1c2_users_table.py
│       └── f7ac3d27bb1d_notifications.py
├── requirements.txt
└── tests.py

```
