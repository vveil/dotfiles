#!/bin/zsh
#
# devconfig.zsh - Work-specific: source devconfig exports and aliases
#

added_keys=$(ssh-add -l)
rc=$?
if [ ${rc} != 0 ]; then
	ssh-add
fi

[[ -f ~/devconfig/export_variables.sh ]] && source ~/devconfig/export_variables.sh
[[ -f ~/devconfig/set_aliases.sh ]] && source ~/devconfig/set_aliases.sh
