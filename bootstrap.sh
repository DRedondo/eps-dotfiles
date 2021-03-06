#!/usr/bin/env bash

{ # Proteccion ejecuccion parcial

# Colorines
NORMAL=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

# Utilidades
echo2() { >&2 echo "$@";                                            	}
info()  { echo2 "$GREEN==> $NORMAL$@$NORMAL";                       	}
infoB() { echo2 "$GREEN==> $NORMAL$BOLD$@$NORMAL";                  	}
error() { echo2 "$MAGENTA==> $NORMAL${BOLD}error: $NORMAL$@$NORMAL";	}
abort() { error "$@"; exit 1;                                       	}
prompt() {
	read -p "${YELLOW}$1 ${BOLD}[S/n]${NORMAL} " # -n 1 -r
	[[ -z $REPLY || $REPLY =~ ^[YySs]$ ]]
	return $?
}

# ----------------------------------------------------------------------------

infoB "======================================================================"
infoB " eps-dotfiles -- instalacion/reconfiguracion"
infoB "======================================================================"

PREFIX="$HOME/UnidadH"
GITREPO="https://github.com/ManuelBlanc/eps-dotfiles.git"
# Preparacion
test -d "$PREFIX" || abort "La ~/UnidadH/ no esta disponible"
cd "$PREFIX"

infoB "Buscando una instalacion ya existente ..."

if [ -d "$PREFIX/eps-dotfiles" ]; then
	info "Encontrada en $PREFIX/eps-dotfiles, actualizando ..."
	cd "$PREFIX/eps-dotfiles"
	git pull --ff-only -v origin master
else
	info "No se encontro ninguna instalacion"
	prompt "Desea instalar en $PREFIX/eps-dotfiles ($GITREPO)?" || abort "instalacion abortada"

	infoB "Clonando el repositorio"
	git clone -v "$GITREPO" "$PREFIX/eps-dotfiles"
	cd "$PREFIX/eps-dotfiles"
fi

infoB "Enlazando los ficheros de configuracion"
## Enlazado manual
link_file() { ln -fs "$PREFIX/eps-dotfiles/$1" "$HOME/$1"; }
# Git
mkdir -p ~/.config/git
link_file .config/git/ignore
link_file .gitconfig
# Bash
link_file .bash_prompt
link_file .bashrc
link_file .inputrc
# Vim
link_file .vimrc

## TODO: Vale la pena automatizar esto?

# for f in $(find "$EPSPREFIX" -type f ! -name README.md ! -path './.git/?*'); do
#	mkdir -p $(dirname "$f")
#	ln -s "$EPSPREFIX$(basename "$f")" $(dirname "$f")
# done


## Terminal negra
infoB "Cambiando el perfil de la terminal"
bash "$HOME/UnidadH/eps-dotfiles/term-colors.sh"

infoB "Cargando ficheros adicionales"

## Recargamos la configuracion
infoB "Recargando la configuracion"
set +eu
cd ~
bind -f ~/.inputrc
. ~/.bashrc

}
