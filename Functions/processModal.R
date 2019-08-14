processModal <- function(gif_location,text='Loading...',background_colour='#FFFFFF'){
  background_rgb <- hex_rgb(background_colour)
  
  div(id='shiny-modal',class="modal",tabindex="-1",`data-backdrop`="static",`data-keyboard`="false",style=sprintf("background: rgba(%s,%s,%s,0.6);",background_rgb$r,background_rgb$g,background_rgb$b),
      div(class="modal-dialog-loading",
          div(class="modal-content-loading",
              div(class="modal-body",
                  div(class="v-app-loading__loading-tile",
                      img(src=gif_location,alt=text),
                      tags$span(text)
                  )
              )
          )
      ),
      tags$script("$('#shiny-modal').modal().focus();")
  )
}
