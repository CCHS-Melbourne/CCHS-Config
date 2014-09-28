class cambam {
	# This configuration package is to manage installing and configuring
	# cambam
	
	package { 'CamBam plus 0.9.8':
                ensure          =>      '0.9.9006',
		source		=>	"\\\\puppet\\software\\CamBamPlus-0.9.8N.msi"
        }

	file { 'C:\ProgramData\CamBam plus 0.9.8':
		ensure		=>	'file',
		source		=>	"\\\\puppet\\software\\CamBam plus 0.9.8",
		recurse		=>	true,
	}

}
