set ts=2
set sw=2

command Run execute "!crystal run src/flight_crusader.cr"
command Build execute "!crystal build src/flight_crusader.cr"
command Format execute "!crystal tool format %"

nmap <leader>b :Build<CR>
nmap <leader>r :Run<CR>
nmap <leader>f :Format<CR>
