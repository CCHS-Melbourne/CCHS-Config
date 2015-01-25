class uc232a {
	# This configuration package is to manage installing and configuring
	# 
	
	package { 'UC232A_Win 7_64bit':
                ensure          =>      '1.0.078',
		source		=>	"\\\\puppet\\software\\UC232A_Windows_Setup.exe"
        }

}
