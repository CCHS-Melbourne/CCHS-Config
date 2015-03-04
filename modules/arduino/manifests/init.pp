class arduino {
	# This configuration package is to manage installing and configuring
	# arduino for windows
	
	package { 'Arduino':
                ensure          =>      '1.0.6',
		source		=>	"\\\\puppet\\software\\arduino-1.0.6-windows.exe"
        }

	file { 'arduino preferences':
		path		=> 'C:\Users\hacker\AppData\Roaming\Arduino\preferences.txt',
		ensure		=> 'file',
		source		=> "\\\\puppet\\software\\arduino\\preferences.txt",
	}

	file { 'C:\Program Files (x86)\Arduino\examples':
		ensure		=> 'directory',
		source		=> "\\\\puppet\\software\\arduino\\examples",
		recurse		=> true,
	}

}
