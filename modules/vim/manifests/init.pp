class vim {
	# added some extensions to work with redhat 5.10 and debian/ubuntu

	 case $::osfamily {
		debian: {
			$vim_tiny_package = 'vim-tiny'
			$vim_package = 'vim'
		}
		redhat: {
			$vim_package = 'vim-enhanced'
		}
	}


	if $vim_tiny_package {
		package { $vim_tiny_package:
			ensure		=> purged,
			before		=> Package[ $vim_package ],
		}
	}

	if $vim_package {
		package { $vim_package:
			ensure		=> latest,
		}
	}
}
