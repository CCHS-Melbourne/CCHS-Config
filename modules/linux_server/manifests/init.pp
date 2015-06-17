class linux_server {
	# this class defines a few things our linux servers have in common
	# mostly users

	group { 'software':
		ensure	=> present,
		gid => 1003,
	}

	account { 'mage':
		# This is John Spencer
		password	=> '$6$aH.ZEbl8$aPCBO.mrdfkfilUegfuMsvGwNhVYJWz3uUJxBKuZw3ctvBudUCTsrdh5WpZAQ1/4jIyLh8iLLmV3mnyPIOZxx/',
		uid		=> '1000',
		groups		=> [cdrom, floppy, sudo,audio,dip,video,plugdev,software],
	}

	account { 'cef':
		# This is Stuart Young
		password	=> '$6$tGV6RwuH$lgwTplTfvurksMOsR/J0TpnB821mQ5wmpw4qne0t1gz6X2FFPWxYRjUMkiErBuUDSMij5bxfeVbPuTLVqrbJm.',
		uid		=> '1001',
		groups		=> [sudo,software],
	}

	account { 'dchanter':
		# This is David Chanter
		password	=> '$6$JHQgrpw.$RqvTrDAOa2kArXhvBeSesZta2wXUHYMD6LMrzGi1VFRhnwitq.mdXII8LtBce5r2AsMO5JrLCkNv6zxxnbSi0/',
		uid		=> '1004',
		groups		=> [software],
	}

	account { 'nash':
		# This is Greg Nash
		password	=> '$6$JEsjq0Uk$YwxwsngoLgpAMCuU4mIsfiY9jYvLslft9o6NHLgFRWPrISMswbg1PVqKZdxUe4ZJsWHwRuOO4j9o7YQJkponj/',
		uid		=> '1002',
		groups		=> [software],
	}

	account { 'alec':
		# This is Alec Clews
		password	=> '$6$DZOrMWCl$IauB8xuF8Nc68ilHyxSNQ4GhCuC3C/Nqlde1YUVXI8vi8K.vW1oGRMmCjpAo0z0/PAZyZK.vj9UW7/mrB7bF..',
		uid		=> '1005',
		groups		=> [software],
	}

	account { 'andyg':
		# This is Andy Gelme
		password	=> '$6$x8ggM2FG$ALORpIXaMlmDALDrWjBHyRRokoeO138pCiGDTne.rkd0/sbJljxHHqW6HK3FOBBaDVmaLxwtSRT.JBpDbDOpK1',
		uid		=> '1006',
		groups		=> [software],
	}

	# 1007 is anton

	account { 'rgannon':
                # This is Rob Gannon
                password        => '$6$ZqnjkY8H$ddpdSQ3WW.pXUCnD6tTgchhRPuOGNpSv5m/ZUWYWX0bvQWL/Onn0iOI7XOGscvJD.fPG/JjBG3.avaW01pSZ30',
                uid             => '1008',
                groups          => [software],
        }

}
