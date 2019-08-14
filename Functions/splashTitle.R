# Adapted from shinyLP::jumbotron

hex_rgb <- function(colour){
  stopifnot(is.character(colour))
  text <- strsplit(gsub('#','',colour),'')[[1]]
  return(
    list(
    'r'= strtoi(tolower(paste(c('0x',text[1:2]),collapse=''))),
    'g' = strtoi(tolower(paste(c('0x',text[3:4]),collapse=''))),
    'b' = strtoi(tolower(paste(c('0x',text[5:6]),collapse='')))
  )
  )
}

splash_title <- function(header, content, button = TRUE, button_label,img_loc,overlaycolour=rgb(121/255,28/255,153/255)){
  overlay_rgb <- hex_rgb(overlaycolour)
  if(button){
    div(class = "jumbotron",style=sprintf("height: 400px; background: linear-gradient(rgba(%s,%s,%s, 0.45),rgba(%s,%s,%s, 0.45)),url('%s');background-repeat: no-repeat;background-position: 50%% 50%%;background-size: cover;",overlay_rgb$r,overlay_rgb$g,overlay_rgb$b,overlay_rgb$r,overlay_rgb$g,overlay_rgb$b,img_loc),
        div(class="jumbotron-content",style="position: relative; top: 50%; transform: translateY(-50%);",
            p(header,style="font-size: 70px;color: rgb(225,225,225); text-shadow: 2px 2px 5px #000000;"),
            p(content,style='color: rgb(200,200,200); text-shadow: 1px 1px 3px #000000;'),
            p(a(class = "btn btn-primary btn-lg button",id = "tabBut", button_label))
        )
    )
  }else{
    div(class = "jumbotron",style=sprintf("height: 400px; background: linear-gradient(rgba(%s,%s,%s, 0.45),rgba(%s,%s,%s, 0.45)),url('%s');background-repeat: no-repeat;background-position: 50%% 50%%;background-size: cover;",overlay_rgb$r,overlay_rgb$g,overlay_rgb$b,overlay_rgb$r,overlay_rgb$g,overlay_rgb$b,img_loc),
        div(class="jumbotron-content",style="position: relative; top: 50%; transform: translateY(-50%);",
            p(header,style="font-size: 70px;color: rgb(225,225,225); text-shadow: 2px 2px 5px #000000;"),
            p(content,style='color: rgb(200,200,200); text-shadow: 1px 1px 3px #000000;')
        )
    )
  }
}
