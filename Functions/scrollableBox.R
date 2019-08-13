scrollableBox <- function (..., title = NULL, footer = NULL, status = NULL, solidHeader = FALSE,
                          background = NULL, width = 6, height = NULL, collapsible = FALSE,
                          collapsed = FALSE)
{
  boxClass <- "box"
  if (solidHeader || !is.null(background)) {
    boxClass <- paste(boxClass, "box-solid")
  }
  if (!is.null(status)) {
    validateStatus(status)
    boxClass <- paste0(boxClass, " box-", status)
  }
  if (collapsible && collapsed) {
    boxClass <- paste(boxClass, "collapsed-box")
  }
  if (!is.null(background)) {
    validateColor(background)
    boxClass <- paste0(boxClass, " bg-", background)
  }
  style <- NULL
  if (!is.null(height)) {
    validatedHeight <- validateCssUnit(height)
    if(!grepl('px',validatedHeight)){
      stop('Height must be specified in px')
    }
    if(grepl('px',height)){
      height <- as.numeric(gsub('px','',height))
    }
    if(height<80){
      stop('Height must be more than 80px')
    }
    style <- paste0("height: ", validatedHeight)
    if(is.null(title)){
      contentHeight <- validateCssUnit(height-20)
    }else{
      contentHeight <- validateCssUnit(height-60)
    }
  }else{
    contentHeight <- NULL
  }

  titleTag <- NULL
  if (!is.null(title)) {
    titleTag <- h3(class = "box-title", title)
  }
  collapseTag <- NULL
  if (collapsible) {
    buttonStatus <- ifelse(!is.null(status),status,"default")
    collapseIcon <- if (collapsed)
      "plus"
    else "minus"
    collapseTag <- div(class = "box-tools pull-right", tags$button(class = paste0("btn btn-box-tool"),
                                                                   `data-widget` = "collapse", shiny::icon(collapseIcon)))
  }
  headerTag <- NULL
  if (!is.null(titleTag) || !is.null(collapseTag)) {
    headerTag <- div(class = "box-header", titleTag, collapseTag)
  }
  if(!is.null(contentHeight)){
    return(
      div(class = if (!is.null(width))
      paste0("col-sm-", width), div(class = boxClass, style = if (!is.null(style))
        style, headerTag, div(class = "box-body", div(style = sprintf('overflow: auto; height: %s;',contentHeight), ...)
        ), if (!is.null(footer))
          div(class = "box-footer", footer)))
    )
  }else{
    return(
      div(class = if (!is.null(width))
      paste0("col-sm-", width), div(class = boxClass, style = if (!is.null(style))
        style, headerTag, div(class = "box-body", ...), if (!is.null(footer))
          div(class = "box-footer", footer)))
    )
  }
}

