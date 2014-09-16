class sketchup {
	# This configuration package is to manage installing and configuring
	# Sketchup
	
	package { 'SketchUp 2014':
                ensure          =>      '14.1.1282',
		source		=>	"\\\\puppet\\software\\SketchUpMake-en.exe"
        }

}
