#1/usr/bin/env bash

cd ~


## Clonar repositorio git
git init .
git remote add origin https://github.com/ManuelBlanc/eps-dotfiles.git
git pull --depth=1 origin master
git checkout -f master


## Terminal negra
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_columns'   	--type int '100'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_rows'      	--type int '30'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_custom_default_size'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/font'                   	--type string 'DejaVu Sans Mono 14'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_system_font'        	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_show_menubar'   	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_theme_colors'       	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/palette'                	--type string '#000000000000:#EFEF29292929:#8A89E2E13433:#FCFCE9E84F4F:#FCFCAFAF3E3D:#ADAD7F7FA8A7:#72729F9FCFCF:#D3D3D7D7CFCF:#555557575353:#A4A400000000:#4E4E9A990605:#C4C4A09F0000:#CECE5C5B0000:#5C5B35356666:#201F4A4A8787:#EEEEEEEEECEC'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/alternate_screen_scroll'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/background_color'       	--type string '#000000000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/visible_name'           	--type string 'Predeterminado'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/bold_color'             	--type string '#000000000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/foreground_color'       	--type string '#F3F2F3F2F3F2'

>&2 echo 'Traido ficheros del repositorio y cambiado la configuracion de la terminal'
>&2 echo 'Es posible que sea necesario abrir una terminal nueva para que los cambios'
>&2 echo 'entren en efecto.'

# Ejecutamos el .inputrc
bind -f ~/.inputrc
# Ejecutatamos el .bashrc
. ~/.bashrc

