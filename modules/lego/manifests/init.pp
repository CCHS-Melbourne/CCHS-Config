class lego {
	# This configuration package is to manage installing and configuring
	# lego
	
	package { 'LEGO MINDSTORMS NXT Software v2.0':
                ensure          =>      'installed',
		source		=>	"\\\\puppet\\software\\Lego-NXT\\setup.exe"
        }

}
