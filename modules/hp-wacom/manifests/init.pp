class hp-wacom {
	# This configuration package is to manage installing and configuring
	# the hp wacom software and drivers on the Elitebooks

	file { 'C:\Software\HP-Wacom':
		ensure		=>	'directory',
		source		=>	"\\\\puppet\\software\\HP-Wacom",
		recurse		=>	true,
	}

	exec { 'hp-wacom-setup.exe':
		path		=>	'C:\Software\HP-Wacom',
		command		=>	'C:\Software\HP-Wacom\Setup.exe',
		refreshonly	=>	true,
		subscribe	=>	File['C:\Software\HP-Wacom'],
		require		=>	File['C:\Software\HP-Wacom'],
	}
	
}
