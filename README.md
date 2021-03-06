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


###Usage###

For each minion, Vagrant will bootstrap a VM named `minion[MINION_NUMBER]`, where MINION_NUMBER starts from 1. For example, to access `minion1` use the following command:

```
$ vagrant ssh minion1
```

If you want to change the number of minions, open `Vagrantfile` in your favorite editor, locate `NODE_COUNT = 2` variable assignment and change the number to what you want (remember that it will create VMs on your computer, so try not to oversubscribe it).

To change parameters of VMs (like number of vCPUS or amount of memory), please, refer to [Vagrant Documentation](https://docs.vagrantup.com/v2/virtualbox/configuration.html)


###Using with tmux tmuxinator###

Working over SSH with multiple VMs without terminal multiplexer is painful, so I strongly recommend to use either `tmux` or `screen` for that.

If you're using tmux, there is an excellent little utility called [tmuxinator](https://github.com/tmuxinator/tmuxinator), which allows you to 

I'm using the following configuration (can be replicated by running `mux create salt_vagrant` and pasting the following snippet to the opened YAML file):

```
# ~/.tmuxinator/salt_vagrant.yml

name: salt_vagrant
project_root: .


windows:
  - vagrant:
      layout: main-vertical
      panes:
        - vagrant ssh master
        - vagrant ssh minion1
        - vagrant ssh minion2
```

Which gives me the following 3-pane layout, where main pain automatically connected to master and secondary panes are connected to minions:

![tmuxinator salt-playground](http://drive.google.com/uc?export=view&id=0B2LdLvvlL_sPX2NBdTBtZ2xYS3M)
