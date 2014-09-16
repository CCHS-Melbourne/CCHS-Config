node /^elitebook-\d+\-g$/ inherits linuxnode {
	
	package { 'gnome-session-flashback':
		ensure		=> present,
	}
	
	
}
