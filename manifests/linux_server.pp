node linux-server {
	

	class { "linux_server": }

}

node cchs-storage inherits linux-server {
}
