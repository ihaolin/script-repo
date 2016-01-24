# Install fab

* prepare

```bash
sudo yum -y group install 'development tools' 
sudo yum install python-devel
```

* install pip

```bash
wget pip...
cd pip...
sudo python setup.py install
```

* install fabric

```bash
sudo pip install fabric
```

***NOTE***(maybe you will meet):

* AttributeError: 'module' object has no attribute 'HAVE_DECL_MPZ_POWM_SEC'

```bash
sudo pip install pycrypto-on-pypi
```