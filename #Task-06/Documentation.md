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
   
