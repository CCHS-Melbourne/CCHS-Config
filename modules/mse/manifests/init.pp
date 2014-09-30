class mse {
	# This configuration package is to manage installing and configuring
	# Microsoft Security Essentials plus updates
	
	package { 'Microsoft Security Essentials':
                ensure          =>      'installed',
                #source         =>      'puppet:///modules/cambam/CamBamPlus-0.9.8N.msi',
		source		=>	"\\\\puppet\\software\\MSE\mseinstall.exe",
        	install_options =>	[ '/s', '/q', '/o', '/runwgacheck' ]
	}

	package { 'MSE updater':
		#ensure		=>	'file',
		source		=>	"\\\\puppet\\software\\MSE\mpam-fe.exe",
        	install_options =>	[ '/q' ]
	}

}
