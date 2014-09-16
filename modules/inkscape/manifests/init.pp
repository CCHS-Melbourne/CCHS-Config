class inkscape {
	# This configuration package is to manage installing and configuring
	# inkscape

	file { 'C:\Software\Inkscape-Extensions':
		ensure		=>	'directory',
		source		=>	"\\\\puppet\\software\\inkscape-extensions",
		recurse		=>	true,
		require		=>	Package['Inkscape 0.48.4'],
	}

	exec { 'EB_Ext_2_2_2_r3.exe':
		path		=>	'C:\Software\Inkscape-Extensions',
		refreshonly	=>	true,
		subscribe	=>	File['C:\Software\Inkscape-Extensions'],
		require		=>	File['C:\Software\Inkscape-Extensions'],
	}
	
	exec { 'UBWDriverInstaller_v20.exe':
		path		=>	'C:\Software\Inkscape-Extensions',
		refreshonly	=>	true,
		subscribe	=>	File['C:\Software\Inkscape-Extensions'],
		require		=>	File['C:\Software\Inkscape-Extensions'],
	}

	package { 'Inkscape 0.48.4':
                ensure          =>      '0.48.4',
		source		=>	"\\\\puppet\\software\\inkscape-0.48.4-1-win32.exe"
        }

}
