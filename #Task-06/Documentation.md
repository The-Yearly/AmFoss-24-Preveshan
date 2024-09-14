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
   
   
