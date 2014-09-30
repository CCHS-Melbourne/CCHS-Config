class windows_settings {
	# custom module for CCHS windows desktops
	# set things like backgrounds and clean files off desktop here.

	#  this sets our task bar to be standardised.
	file { 'C:\Users\hacker\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar':
		ensure		=> 'directory',
		source		=> "\\\\puppet\\software\\Desktop\\TaskBar",
		recurse		=> true,
		purge		=> true,
	}

	# Set the windows background
	file { 'background_local':
		path		=> 'C:\Software\Desktop',
		ensure		=> 'directory',
		source		=> "\\\\puppet\\software\\Desktop",
		recurse		=> true,
		purge		=> true,
		notify		=> Exec['run_bgi'],
	}

	exec { 'run_bgi':
		command		=> "C:\Software\Desktop\Background\Bginfo.bat ",
		refreshonly	=> true,
	}

	# clean desktop, downloads and documents
	#file { 'desktop_files':
	#	path		=> 'C:\Users\hacker\Desktop',
	#	ensure		=> 'directory',
	#	source		=> "C:\Software\Desktop\Desktop",
	#	require		=> Exec['clear_directories'],
	#}
	
	# This causes problems :/
	#exec { 'clear_directories':
	#	command		=> "C:\Software\Desktop\Cleanup\cleanup.bat ",
	#	require		=> File['background_local'],
	#}
}
