TiddlyWeb at Home - Vagrant
---------------------------

### Dependencies

 * VirtualBox .. http://virtualbox.org/
 * Vagrant .. http://www.vagrantup.com/
 * optional git .. 

### Manual 'hosts' File Setting

**unix**

 * add the follwinig line to `/etc/hosts` 

**windows** 

 * add the follwinig line to `C:\Windows\System32\drivers\etc\hosts` 

```
# needed for tweb-at-home vagrant setup
192.168.3.10	tweb.local
```

### Installation Using the Release Version (may be out of date but stable)

 * Download the latest release at: https://github.com/pmario/tweb-vagrant/releases
 * create an instance directory eg: tiddlyweb
 * extract the `Vagrantfile` and the `assets` folder to your instance directory
 * cd tiddlyweb
 * continue with `Start the TiddlyWeb Instance`

### Installation Using git
 
 * git clone https://github.com/pmario/tweb-vagrant.git
 * cd tweb-vagrant
 * continue with `Start the TiddlyWeb Instance`

### Start a TiddlyWeb Instance

 * make sure you are at your instance directory.
 * `vagrant up`
 
 ... the first run will take several minutes
 
  * `vagrant reload` ... is needed to autostart the TiddlyWeb server

**click**: http://tweb.local:8080/default ... to open the default TiddlyWiki<br />
**click**: http://tweb.local:8080 ... to open tiddlyweb 

have fun!
mario

**Vagrant Documentation**

 * see: http://docs.vagrantup.com/v2/