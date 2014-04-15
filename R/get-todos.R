dir_list <- list.dirs()
file_list <- list.files("test_project/") # add recursive = TRUE later

patterns <- "TODO[\\s]*?:+(?P<todo>.*)$"

files <- lapply(file_list, function(x) readLines(con = paste0("test_project/", x)))
lapply(files, function(file) grep(pattern = patterns, x = file, perl = TRUE))
results <- lapply(files, function(file) grep(pattern = patterns, x = file, perl = TRUE))


lapply(results, function(x) files[x])

get_todos <- function(file, lines) file[lines]

todo_list <- mapply(get_todos, files, results)

for(i in seq_along(todo_list)){
  names(todo_list)[i] <- file_list[i]
}
rm_files <- unlist(lapply(todo_list, function(x) ifelse(length(x) == 0, 0, 1) ))

todo_list[rm_files != 0]

