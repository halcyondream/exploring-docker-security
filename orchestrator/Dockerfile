FROM ubuntu:18.04

RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive \
		apt-get -y --no-install-recommends -qq install \
			openssh-server \
			apt-utils \
			libcap2-bin \
			curl \
			ca-certificates \
			sudo && \
	mkdir -p /var/run/sshd && \
	mkdir -p /root/.ssh && \
	mkdir -p /etc/pki/tls/certs && \
	echo "Packages installed"

RUN curl -sSL https://get.docker.com/ | sh

RUN useradd -m bob -s /bin/bash && \
	mkdir -p /home/bob/.ssh && \
	echo "bob:qwertyqwerty" | chpasswd && \
	echo "Standard user successfully added"

RUN echo "bob ALL=(ALL,!root) NOPASSWD: /bin/bash" >> /etc/sudoers && \
	echo "bob user added to sudoers"

WORKDIR /etc/ssh

RUN echo "root:$(head -c 64 /dev/urandom | sha256sum | cut -d ' ' -f 1)" | chpasswd && \
	echo "Successfully changed root password" && \
	sed --in-place 's/^\(UsePAM\|PermitRootLogin\)/#\1/' sshd_config && \
	echo "" >> sshd_config && \
	echo "UsePAM no" >> sshd_config && \
	echo "PermitRootLogin yes" >> sshd_config && \
	echo "SSHD updated" 

USER root

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]