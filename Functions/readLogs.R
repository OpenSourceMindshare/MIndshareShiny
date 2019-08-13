read_git_logs <- function(minorChange='#minor',majorChange='#major'){
  if(file.exists('.git\\logs\\refs\\heads\\master')){
    readLines('.git\\logs\\refs\\heads\\master') %>%
      as_tibble()%>%
      separate(value,c('Junk','Details'),': ')%>%
      select(-Junk)%>%
      mutate('Fork'=cumsum(grepl('#fork',Details)))%>%
      group_by(Fork)%>%
      mutate('Major'=cumsum(grepl('#major',Details)),
             'Minor'=cumsum(grepl('#minor',Details)))%>%
      group_by(Fork,Major,Minor)%>%
      mutate('Patch'=row_number()-1)%>%
      unite(Version,c(Major,Minor,Patch),sep='.')
  }else{
    stop('No git file found')
  }
}
