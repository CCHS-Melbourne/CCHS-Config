class kicad {
	# This configuration package is to manage installing and configuring
	# 
	
	package { 'KiCad 2013.07.07':
                ensure          =>      '2013.07.07',
		source		=>	"\\\\puppet\\software\\KiCad_stable-2013.07.07-BZR4022_Win_full_version.exe"
        }

}
