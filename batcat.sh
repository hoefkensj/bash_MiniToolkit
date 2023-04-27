#!/usr/bin/env bash
# ############################################################################
# # PROJECT: bash_MiniToolkit                     AUTHOR: Hoefkens.j@gmail.com
# # FILE: batcat.sh                                                 2023-04-27 
# ############################################################################
#
function batcat ()
{
	local _cat _bat LANG STRING COLOR
	function _bat()
	{
		/usr/bin/env bat --plain --paging="never" --theme="Monokai Extended Origin" --language="$LANG" <<< "$1"			
	}
	function _cat ()
	{
		/usr/bin/env cat <<< "$1"
	}
	LANG="$1"
	shift 1
	STRING="$@"
	got_cat=$( which "cat" )
	got_bat=$( which "bat" )
	[[ -n "$got_bat" ]] &&  _bat "$STRING"
	[[ -z "$got_bat" ]] && _cat "$STRING"
};
batcat "$@"	
unset batcat