# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinyjs)
library(magrittr)
library(jsonlite)
library(promises)
library(future)
library(tibble)
library(magrittr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

quietlySource <- lapply(grep('\\R$',list.files('Functions'),value=TRUE),function(x){
  source(sprintf('Functions/%s',x))
})

# App title that appears within the browser tab
appTitle <- 'Mindshare Shiny Dashboard'
appDescription <- "Example css styling and elements"
# We can define a splash image for the main page
splash_image_location <- "decks.jpg" 

# When the app first loads we have a delay before we remove the process modal
loadRemoveDelaySeconds <- 1.5


plan(multiprocess(workers=ifelse(availableCores()==2,2,availableCores()-1)))


# If there is a git repository attached then we look for flags to identify the version and any commit comments that we may have
appVersion <- if(file.exists('.git\\logs\\refs\\heads\\master')){
  logs <- read_git_logs()
  version <- logs[['Version']][nrow(logs)]
  write_lines(version,'src/currentVersion.txt')
  version
}else{
  if(file.exists('src/currentVersion.txt')){
    version <- paste(read_lines('src/currentVersion.txt'),collapse='\n')
    version
  }else{
    'Stated Version Number: 0.0.0'
  }
}

appVersionDetails <- if(file.exists('.git\\logs\\refs\\heads\\master')){
  logs <- read_git_logs()
  details <- logs[['Details']][nrow(logs)]
  write_lines(details,'src/currentLog.txt')
  details
}else{
  if(file.exists('src/currentLog.txt')){
    details <- paste(read_lines('src/currentLog.txt'),collapse='\n')
    details
  }else{
    'No details to report'
  }
}


# UI ====

# Defines UI for a shinydashboard with sidebar and user drop down.


server<- function(input,output,session){
  
  flags <- reactiveValues(
    'launched'=FALSE,
    'authorised'=FALSE
  )
  
  output$packageRefs <- renderText({
    lapply(sort(c("shiny","shinydashboard","shinydashboardPlus",'shinyLP',"shinyjs","magrittr","jsonlite","promises","future","tibble","magrittr","dplyr","ggplot2","tidyr","readr")),function(x){
      utils::citation(x)$textVersion
    })%>%unlist%>%
    paste(collapse='<hr>')
    
  })
  
  output$mainUI <- renderUI({
    # showModal(processModal(gif_location = 'MSLoading.gif','Starting up...'))
    # fluidPage(
    #   column(width=12,
    #        box(title='Solid Header',solidHeader = TRUE),
    #        box(title='Test',solidHeader = FALSE)
    # ),
    # column(width=12,
    #        tabBox(tabPanel('a'),tabPanel('b')))
    # )
    if(!flags$launched){
      showModal(processModal('MSLoading.gif','Loading...'))
    }else{
      fluidPage(
        tabItems(
          tabItem(tabName = 'Home',
                  splash_title(
                    appTitle,
                    appDescription,
                    FALSE,
                    "No Button",
                    img_loc=splash_image_location,overlaycolour = '#707070'
                  ),
                  scrollableBox(
                    title='App Details',
                    p(sprintf('Version: %s',appVersion)),
                    p(appVersionDetails),
                    width=3,height = '200px'
                  ),
                  scrollableBox(
                    title='Using this template',
                    HTML("You are free to use this template and associated functions as you want, however we ask that you cite this project accordingly. <br><br> To cite this project please use: \n \"Mindshare (2019) - Simon Wallace. Open Source Mindshare: Shiny Dashboard Template, Formatting, and Functions. https://github.com/OpenSourceMindshare/MindshareShiny\""),
                    
                     width=6,height = '200px'
                  ),
                  scrollableBox(
                    title='More Information',
                    # column(width=12,
                      HTML('Within this template we demonstrate different functions that we use within shiny applications: <br><br> <b>1) Process Modal</b> <br> A modal that we can use to display the session is busy to prevent inputs, especially useful when combined with promises. Click'),
                    actionLink('loading','here'),  
                    HTML('to display a loading screen for 2 seconds. <br><br><b>2) Scrollable Box</b><br>A box that scrolls to the content within and the height specified within the box definition  <br><br><b>3) Jumbotron Splash Screen</b><br> We have adapted the jumbotron class within Bootstrap to enable us to use and image within and place a colour overlay on the image <br><br><b>4) Dropdown header</b><br> This dropdown allows us to place only a secondary menu in the top right of the dashboard. It can be used for anything however we use it to display user information and links to shared locations. <br><br><b>5) Read git logs</b><br> We pull commit message from the project\'s git and looking for particular tags we create a version number and version details. This is particularly useful when testing as we know the version that is being used and allows us to define version changes easily.'),
                    # ),
                    
                    width=3,height = '200px'
                  )
          ),
          tabItem(tabName = 'Refs',
                  h3('Packages'),
                  htmlOutput('packageRefs')
          )
        )
      )
    }
  })
  
  observeEvent(input$loading,{
    showModal(processModal('MSLoading.gif','Loading...'))
    future({
      Sys.sleep(2)
    })%...>%
      (function(x){
        removeModal(session=session)
      })
  })
  
  output$sidebar <- renderUI({
    sidebarMenu(id = "sidebar_id",style = "position: fixed; overflow: visible;",
                menuItem("Home", tabName = "Home", icon = icon("home")),
                menuItem("References", tabName = "Refs", icon = icon("book"))
    )
  })
  
  observe(
    # If we have authorisation or pre loading things that we need to do we can do so here
    if(!flags$launched){
      flags$launched <- TRUE
    }else{
      updateTabItems(session,"sidebar_id",selected = "Home")
      future({
        Sys.sleep(loadRemoveDelaySeconds)
      })%...>%
        (function(x){
          removeModal(session=session)
      })
    }
  )
}

ui <- dashboardPagePlus(
  title=appTitle,
  
  # We don't edit this, instead we define our UI in the server within "mainUI".
  dashboardHeaderPlus(title=tags$a(tags$img(src='MSWW.png',height='100%',title='')),
                      dropdownHeaderUser(HTML("<i class=\"fa fa-user-circle\"></i> A.Nonymous"),
                                     'Information that we want to let the user know about the content below.',
                                     fluidRow(
                                       column(width=6,actionButton('headerButton1','Button A',width='100%')),
                                       column(width=6,actionButton('headerButton2','Button B',width='100%'))
                                     )
                                     ),
                      enable_rightsidebar = FALSE,
                      disable=FALSE),
  dashboardSidebar(uiOutput('sidebar')),
  sidebar_fullCollapse = TRUE,
  dashboardBody(
    includeCSS('www/MindshareShiny.css'),
    useShinyjs(),
    uiOutput('mainUI'),
    # Makes sure the header stays in place
    tags$script(HTML("$('body').addClass('fixed');"))
  )
)

# Run app ====
shinyApp(ui = ui, server = server)

