# Overview
Microblog by Micheal Gunberg is a web application created using pyhon and flask
# Functionality
 ### Init
  - **```create_app``` :** This function is for the seting up of the Flask application with its main components including database, authentication, email, internationalization, and background task management functionalities
  - **get_locale :** Gets the best local language settings available
 ### Cli(Command Line Interface)
   - **```translate()``` :** Translates Command To Local Language
   - **```init(lang)``` :** Setups A New Language For Translation
   - **```update()``` :** Updates All Language Settings
   - **```compile()``` :** Compiles All Langues Files
### Search
  - **```add_to_index(index, model)``` :** Adds Object To Be Searched On Elastic Search
  - **```remove_from_index(index, model)``` :**Removes Objects Frm Elasti Search
  - **```query_index(index, query, page, per_page)``` :** Searches ElasticSearch And produces the result
### Models
- **SearchableMixin : Provides functionality for indexing and searching model instances in Elasticsearch.**
   - **```search(cls, expression, page, per_page)``` :** Returns page of query result when found
   - **``before_commit(cls, session)`` :** Stores All Data Changes Before Commiting
   - **```after_commit(cls, session)``` :** Updates Changes
   - **``reindex(cls)``:** Reindex's All Elements Based On Changes Made
 - **```PaginatedAPIMixin``` : Proviedes pagination for Api Responces**
    - ```to_collection_dict(query, page, per_page, endpoint, **kwargs)``` :*** Converts query responce in paginated dictionary format
 - **User: Contains User Attributes And Functions**
   - **```_repr__(self) ```:** Returns a string representation of the user
   - **```set_password(self, password)```:** Sets the user password
   - **```check_password(self, password)``` :** Checks If Passwords Match
   - **```avatar(self, size)``` :** Provides Users Avatar
   - **```follow(self, user):``` :** Adds User to their follow list
   - **```unfollow(self, user)``` :*** Removes a user from the following list
   - **```is_following(self, user)``` :** Checks if the user is following other user
   - **```followers_count(self)``` :** Returns the count of followers
   - **```following_count(self)```:** Provides Following Count
   - **```following_posts(self)``` :** Provides recent posts from users the person follows
   - **```get_reset_password_token(self, expires_in=600)``` :** Generates reset pass token
   - **```verify_reset_password_token(token)``` :** Verifies a reset password token
   - **```unread_message_count(self)``` :** Provides number of unreade messages
   - **```add_notification(self, name, data)``` :** Adds notification
   - **```launch_task(self, name, description, *args, **kwargs)``` :** Starts Background Task
   - **```get_tasks_in_progress(self)``` :** Retrieves tasks that are currently in progress
   - **```get_task_in_progress(self, name)``` :** Retriives Task in prograss based on specific name
   - **```posts_count(self)``` :** Retrieves Number Of Posts Made By User
   - **```to_dict(self, include_email=False)``` :** Converts user data into dictionary except for email
   - **```from_dict(self, data, new_user=False)```:** Updates the user object from a dictionary
   - **```get_token(self, expires_in=3600)``` :** Retrieves an authentication token
   - **```revoke_token(self) ```:** Revokes User Token
   - **```check_token(token)```:** Checkss the validity of toen   
   
