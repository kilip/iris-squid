USERNAME := kilip
APP_NAME := iris-squid
SQUID_VERSION := 5.0.1
SQUID_CONFIGURE := "--build=x86_64-generic-linux-gnu --with-openssl --enable-ssl-crtd --enable-icmp --enable-snmp --prefix=/squid"

build:
	docker build \
		--build-arg SQUID_VERSION=$(SQUID_VERSION) \
		--build-arg SQUID_CONFIGURE=$(SQUID_CONFIGURE) \
		--no-cache \
		-t $(USERNAME)/$(APP_NAME) .