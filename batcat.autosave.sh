#!/usr/bin/env bash
# ############################################################################
# # PROJECT: bash_MiniToolkit                     AUTHOR: Hoefkens.j@gmail.com
# # FILE: batcat.sh                                                 2023-04-27 
# ############################################################################
#
function batcat () {
	function _bat() {
		local theme paging batopts 
		theme="Monokai Extended Origin"
		paging="never"
		batopts="--plain --paging=$paging --theme=$theme --language=$lang"
		bat $batopts <<< "$@"			
	}
	local lang
	lang="$1" 
	shift 1 #remove that from the args as cat doesnt need it
	[[ -n "$( which bat )" ]] &&  _bat "$@"
	[[ -z "$( which bat )" ]] && echo $( printf '%s' "$@" ) | $( printf '%s' "$(which cat)"  ) 
};	
batcat $@
unset batcat