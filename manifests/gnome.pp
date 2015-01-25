node /^elitebook-\d+\-g$/ inherits linuxnode {
	
	package { 'gnome-session-flashback':
		ensure		=> present,
	}

	package { 'idle':
		ensure		=> present,
	}

	package { 'scratch':
		ensure		=> present,
	}

	
	
}
