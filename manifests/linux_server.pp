node linux-server {
	

	class { "linux_server": }

}

node cchs-storage inherits linux-server {
}

node andyg-dev inherits linux-server {
}

node john-dev-machine inherits linux-server {

	 account { 'anton':
                password        => '$6$DJYTDRGG$kyai0JFV6NAzIyOW7iXCtwnyHMF52dp1xIda2ZZUuKDj/wipiav78pphkFKcTZpYVgQkwsetHZNdLLlcuuGBE0',
                uid             => '1007',
                groups          => [cdrom, floppy, sudo,audio,dip,video,plugdev,software],
        }
}
