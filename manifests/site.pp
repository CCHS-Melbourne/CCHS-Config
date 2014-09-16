if $osfamily == 'windows' {
	File { source_permissions => ignore }
}

import 'nodes.pp'

import 'gnome.pp'

import 'windows.pp'
