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

	# Clear the startup directory
	# Because...People
	file { 'Windows Startup':
		path		=> 'C:\Users\hacker\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup',
		ensure		=> 'directory',
		source		=> "C:\Software\Desktop\Startup",
		recurse		=> true,
		purge		=> true,
		require		=> File['background_local'],
	}

	exec { 'run_bgi':
		command		=> "C:\Software\Desktop\Background\Bginfo.bat ",
		refreshonly	=> true,
	}

	# clean desktop, downloads and documents
	file { 'desktop_files':
		path		=> 'C:\Users\Public\Desktop',
		ensure		=> 'directory',
		source		=> "C:\Software\Desktop\Desktop",
		recurse		=> true,
		require		=> Exec['clear_directories'],
	}
	
	# This causes problems :/
	exec { 'clear_directories':
		command		=> "C:\Software\Desktop\Cleanup\cleanup.bat ",
		require		=> File['background_local'],
	}

	# set hosts file
	file { 'hosts':
		path		=> 'C:\Windows\System32\drivers\etc\hosts',
		ensure		=> 'file',
		source		=> "C:\Software\Desktop\hosts",
		require		=> File['background_local'],
	}

}
