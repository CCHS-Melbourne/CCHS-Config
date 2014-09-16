class eagle {
	# This configuration package is to manage installing and configuring
	# eagle
	# eagle doesn't seem to be great at automated installs.
	
	package { 'EAGLE 7.1.0':
                ensure          =>      '7.1.0',
		source		=>	"\\\\puppet\\software\\eagle-win-7.1.0.exe"
        }

}
