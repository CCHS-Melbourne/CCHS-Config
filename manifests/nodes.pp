# basenode - Common elements that all nodes inherit from.
node linuxnode {
	
	class { "vim": }

	package { 'curl':
		ensure		=> installed,
	}

	package { 'sudo':
		ensure		=> present,
	}

	package { 'inkscape':
		ensure		=> present,
	}

	package { 'arduino':
		ensure		=> present,
	}

	package { 'librecad':
		ensure		=> present,
	}

	package { 'png23d':
		ensure		=> present,
	}

	package { 'wine':
		ensure		=> present,
	}

	account { 'hacker':
		password	=> '$6$Mp.Yy96u$Bee.qzdguw7rAN2LrrREkjWL4aFx38jjc/PGLjXRutOB59956nEueZaD6Uv6z.8Bbfbiq3JAz7SJN0joo4prc.',
		uid		=> '1000',
		groups		=> [ 'cdrom','dialout','plugdev','sudo','dip','sambashare' ],
	}
}
