# Marvel Characters

List of Marvel characters and their description.

API: https://developer.marvel.com/docs

## Description

* Architecture based in VIPER
    - Layers
        - Data: DataSource protocol and BaseProvider class
        - Domain: Interactor and models
        - Presentation: 
            - App dependencies: To manage dependencies
            - Base classes
            - Components: Spinner
            - Modules: List and detail
                - Presenter
                - View: Programmatically, no xibs or storybodad
            - App Coordinator: To manage navigation between screens
* Screens:
    - List of characters with their own picture.
        - Initially 50 characters are requested from Avengers series
        - You can search for any character from the search bar at the top of the screen
        - When a character is selected, it navigates to the detail screen
    - Character detail
        - A picture and description of the characters.
        - List of comics and series where the character appears.

* Testing: `Unit Testing` for Presenter, Interactor and DataSource

## Run Requirements
* Xcode 13+
* iOS 15+

**Important:**

For API calls to work you need to get a public and private key for Marvel API.  
Place your keys in the info.plist file.  
    - File key names: `PUBLIC_KEY` and `PRIVATE_KEY`