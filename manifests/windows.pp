node /^elitebook-\d+\-w$/ {
#node "WIN-87620H5T41T" {
	

	# this is just a place to run some of the files we can't 
	# use package to install
	file { 'C:\Software':
		ensure	=>	'directory',
	}

	class { "mse" : }

	class { "cambam": }

	class { "eagle": }

	class { "inkscape": }

	class { "hp-quicklaunch": }
	
	class { "hp-wacom": }
	
	class { "chrome": }

	class { "pronterface": }

	class { "sketchup": }

	class { "arduino": }

	class { "windows_settings": }
	
	class { "lego": }

	class { "kicad": }

	class { "uc232a": }
	
	class { "acrobat_reader": }

}
