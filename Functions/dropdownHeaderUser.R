dropdownHeaderUser <- function(title,body,footer=NULL){
  if(!is.null(footer)){
    tags$li( class="dropdown user user-menu",
             tags$a( href="#", class="dropdown-toggle", `data-toggle`="dropdown",
                     span(class="user-name", title)
             ),
             tags$ul(class="dropdown-menu",
                     tags$li(class="user-body",body),
                     tags$li(class="user-footer",footer)
             )
             )
  }else{
    tags$li( class="dropdown user user-menu",
             tags$a( href="#", class="dropdown-toggle", `data-toggle`="dropdown",
                     span(class="user-name", title)
             ),
             tags$ul(class="dropdown-menu",
                     tags$li(class="user-body",body)
             )
    )
  }
}
