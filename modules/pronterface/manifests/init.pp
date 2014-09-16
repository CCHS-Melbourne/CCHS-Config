class pronterface {
	# This configuration package is to manage installing and configuring
	# pronterface
	# we probably want slightly different pronterface options for 
	# different machines

	file { 'C:\Software\Printrun-Win-Slic3r-10Mar2014':
		ensure		=>	'directory',
		source		=>	"\\\\puppet\\software\\Printrun-Win-Slic3r-10Mar2014",
		recurse		=>	true,
	}

	file { "${win_common_desktop_directory}\\pronterface.lnk":
		ensure		=>	'present',
		source		=>	"\\\\puppet\\software\\Printrun-Win-Slic3r-10Mar2014\\pronterface.lnk",
		require		=>	File['C:\Software\Printrun-Win-Slic3r-10Mar2014'],
	}
}
