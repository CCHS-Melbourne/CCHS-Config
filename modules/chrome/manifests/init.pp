class chrome {
	# This configuration package is to manage installing and configuring
	# the chrome and chromecast

#	file { 'C:\Software\Chrome':
#		ensure		=>	'directory',
#		source		=>	"\\\\puppet\\software\\Chrome",
#		recurse		=>	true,
#	}

	package { 'ChromecastApp':
	#	ensure		=>	'1.5.316.0',
		ensure		=>	'installed',
		source		=>	"\\\\puppet\\software\\Chrome\\chromecastinstaller.exe",
		require		=>	Package['Google Chrome'],
	}

	package { 'Google Chrome':
#		ensure		=>	'37.0.2062.102',
		ensure		=>	'installed',
		source		=>	"\\\\puppet\\software\\Chrome\\ChromeSetup.exe",
	}	
}
