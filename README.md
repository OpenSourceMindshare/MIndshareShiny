# Mindshare Shiny
Shiny is a brilliant tool that enables users to interact with the results of an analysis. Once combined with microservices, and packages like shinydashboard, shinydashboardPlus, and promises we have increase it's ability to do so and the user experience. However customising the user interface and incorporating brand identity is not straightforward to those unfamiliar with CSS and HTML.

We have built helper functions around some of the elements available within Bootstrap, such as the Jumbotron, and we have created a css file and default app template that enables us to easily customise the look and feel of the dashboard/tool to match brand guidelines and improve the user experience. 

These files can be found within this repository and their use is encouraged, all we ask is that you reference its use appropriately. We would also be interested in seeing any ways in which you use/improve these files and functions, please send any examples to osmww\@mindshareworld.com.

## Referencing

To cite this project please use: <br> <i>\"Mindshare (2019) - Simon Wallace. Open Source Mindshare: Shiny Dashboard Template, Formatting, and Functions. https://github.com/OpenSourceMindshare/MindshareShiny"</i>

## CSS

We have created a parameterised CSS file (./www/MindshareShiny.css) that file alters shiny dashboard's default blue skin and has been created to try and make clear which aspects of the dashboard's appearance we are changing. It is not a comprehensive css file and some elements might need further customisation.

## Functions
Within this template we demonstrate different functions (./Functions) that we use within shiny applications: 

<b>1) Process Modal</b> <br> A modal that we can use to display the session is busy to prevent inputs, especially useful when combined with promises. 

<b>2) Scrollable Box</b><br>A box that scrolls to the content within and the height specified within the box definition. 

<b>3) Jumbotron Splash Screen</b><br> We have adapted the jumbotron class within Bootstrap to enable us to use and image within and place a colour overlay on the image 

<b>4) Dropdown header</b><br> This dropdown allows us to place only a secondary menu in the top right of the dashboard. It can be used for anything however we use it to display user information and links to shared locations. Similar to the function within "shinydashboardPlus" it creates a class that we can manipulate with css 

<b>5) Read git logs</b><br> We pull commit message from the project\'s git and looking for particular tags we create a version number and version details. This is particularly useful when testing as we know the version that is being used and allows us to define version changes easily.
