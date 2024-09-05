# Exploring Docker Security

Resources to create a vulnerable "container orchestrator" from scratch.

Supplement to the write-up [here](https://halcyondream.github.io/2024/09/03/Exploring-Docker-Misconfigurations.html).

The Vagrantfile should make a small deployment fairly easy if you are
already using Vagrant. You can run this with `vagrant up` ran from within
this directory. This setup maps the Host SSH to port 22 and the Container
SSH to port 2222 to avoid minor conflicts with Vagrant.

If you don't use Vagrant, just copy the configs to a folder called 
`/provision` on the VM guest and run `provision.sh`. You can modify the
port mappings for the different SSH services if desired.

This approach is easier to deploy, but it also gives you new attack
vectors to consider. As an exercise, you may want to explore the following:

-   Fix the vulnerabilities and redeploy or reprovision

-   Discover "what else" your provisioner may leak

-   Tie this system into other systems to simulate lateral movement 
    through a network