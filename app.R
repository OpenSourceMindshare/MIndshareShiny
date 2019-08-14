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
library(httr)
library(magrittr)
library(jsonlite)
library(openssl)
library(promises)
library(future)
library(tibble)
library(magrittr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(RMySQL)
library(odbc)
library(readr)
library(aws.s3)
library(ggrepel)

quietlySource <- lapply(grep('\\R$',list.files('Functions'),value=TRUE),function(x){
  source(sprintf('Functions/%s',x))
})

# App title that appears within the browser tab
appTitle <- 'Mindshare Shiny Dashboard'

# We can define a splash image for the main page
splash_image_location <- "https://images.unsplash.com/photo-1495834041987-92052c2f2865?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=3d771d2cc226047515072dba7a5f03bc&auto=format&fit=crop&w=1050&q=80"

# When the app first loads we have a delay before we remove the process modal
loadRemoveDelaySeconds <- 1.5


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
  output$mainUI <- renderUI({
    showModal(processModal(gif_location = 'MSLoading.gif','Testing'))
    fluidPage(
      column(width=12,
           box(title='Solid Header',solidHeader = TRUE),
           box(title='Test',solidHeader = FALSE)
    ),
    column(width=12,
           tabBox(tabPanel('a'),tabPanel('b')))
    )
  })
  
  output$sidebar <- renderUI({
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th")),
      sliderInput("b", "Under sidebarMenu", 1, 100, 50),
      menuItem("Sub-items C",
               sliderInput("c1", "Under menuItem 1", 1, 100, 50),
               sliderInput("c2", "Under menuItem 2", 1, 100, 50)
      )
    )
  })
}

ui <- dashboardPagePlus(
  title=appTitle,
  
  # We don't edit this, instead we define our UI in the server within "mainUI".
  dashboardHeaderPlus(title=tags$a(tags$img(src='MSWW.png',height='100%',title='')),
                      dropdownHeaderUser('A.Nonymous',
                                     'Body Content',
                                     column(width=12,
                                            column(width=6,actionButton('button1','A Button')),
                                            column(width=6,actionButton('button1','B Button'))
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

