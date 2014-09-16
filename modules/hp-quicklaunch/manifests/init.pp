class hp-quicklaunch {
	# This configuration package is to manage installing and configuring
	# the hp quicklaunch buttons on the Elitebooks

	file { 'C:\Software\HP-Quicklaunch':
		ensure		=>	'directory',
		source		=>	"\\\\puppet\\software\\HP-Quicklaunch",
		recurse		=>	true,
	}

	exec { 'setup.exe':
		path		=>	'C:\Software\HP-Quicklaunch\Disk1',
		refreshonly	=>	true,
		subscribe	=>	File['C:\Software\HP-Quicklaunch'],
		require		=>	File['C:\Software\HP-Quicklaunch'],
	}
	
}
