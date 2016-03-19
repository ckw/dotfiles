"highlight trailing spaces
hi link SpaceError Error
call matchadd("SpaceError", "\\s\\+$")
