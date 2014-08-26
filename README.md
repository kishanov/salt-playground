#About#

This is a simple utility repository to bootstrap [Salt](http://docs.saltstack.com/en/latest/) playground. It uses VirtualBox and Vagrant to provision:

* 1 VM to be Salt Master (available at `192.168.100.100`)
* n VMs (2 by default) to be Salt Minions (available at `192.168.100.10[1-9]`)

###Installation###

1. Install the latest version of [VirtuaBox](https://www.virtualbox.org/wiki/Downloads) and VirtualBox extension
2. Install [Vagrant](http://www.vagrantup.com/downloads.html)
3. Clone this repository:
```
$ git clone https://github.com/kishanov/salt-playground
$ cd salt-playground
```
4. Start VMs (it will create 3 VMs and provision Salt and it's dependencies)
```
$ vagrant up && vagrant provision
```
5. After provisioning has finished, SSH to master node and accept minion's keys:
```
$ vagrant ssh master
$ sudo salt-key -y -A
```
As a result you should see the following message:
```
$ vagrant@master:~$ sudo salt-key -y -A
The following keys are going to be accepted:
Unaccepted Keys:
minion1
minion2
Key for minion minion1 accepted.
Key for minion minion2 accepted.
```
6. If everything was installed correctly, you should be able to use Salt right away. To test it, you can try to ping minions with the following command:
```
$ sudo salt '*' test.ping
```

And see the following output:


```
$ vagrant@master:~$ sudo salt '*' test.ping
minion1:
    True
    minion2:
        True
```


To destroy an environment, run the following command (from `salt-playground` directory on host machine):
```
vagrant destroy
```
It will kill all VMs so you can reprovision everything and start working from scratch

