processModal <- function(gif_location,text='Loading...'){
  div(id='shiny-modal',class="modal",tabindex="-1",`data-backdrop`="static",`data-keyboard`="false",style="background: rgba(255,255,255,0.6);",
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
      tags$script("$('#shiny-modal').modal().focus();"),
      tags$style(paste(readLines('src/processModal.css'),collapse='\n'))
  )
}
