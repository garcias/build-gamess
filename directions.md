## Getting the source code

[Apply for access to the source code at the GAMESS home page.](http://www.msg.ameslab.gov/gamess/License_Agreement.html) Agree to the terms of the academic license (most notably, that you cannot share the code with anyone) and `Submit`. Check your email for the link to the source-code page, and record the username and password. The password changes weekly, but in the examples below, assume that:

    username: source
    password: eioVvn5U

Once you have the password, you can download the latest version from the [GAMESS homepage](http://www.msg.chem.iastate.edu/GAMESS/download/source/gamess-current.tar.gz). 

## Provisioning

Before you can compile GAMESS, you need to configure your machine, install dependencies, and get the source code into the machine. This process is slightly different for a Cloud9 container than for a Vagrant VM.

### Provision a Cloud9 container

Cloud9 takes care of configuring and creating a container for your workspace, so you only need to install the source code and dependencies. Create a new C++ workspace and open a terminal. 

Use Git to clone this repository. Change into the new directory, and run `Cloud9file` as a shell script with `root` privileges. This will install dependencies needed to compile GAMESS.

```bash
    > git clone git@github.com:garcias/build-gamess.git
    > cd build-gamess
    > sudo sh Cloud9file
```

Copy the GAMESS source code archive (`gamess-current.tar.gz`) into this directory. There are two ways to do this:

- Upload from your computer using the menu command `File > Upload Local Files...` and move them into the folder `build-gamess`.
- Download from the GAMESS homepage using `curl` and the current password. (The actual password will be different from the example below.)

    ```bash
        curl -LO -u source:eioVvn5U http://www.msg.chem.iastate.edu/GAMESS/download/source/gamess-current.tar.gz
    ```

### Provision a Vagrant-managed VM

Vagrant automatically creates and provisions a VM, as specified in the `Vagrantfile`. 

Use Git to clone this repository, or just download it as a .zip and extract into a directory. Change into the new directory.

```bash
    > git clone git@github.com:garcias/build-gamess.git
    > cd build-gamess
```

Download and place the source code archive (`gamess-current.tar.gz`) into this new directory. A convenient way to do this is with `curl` if you have it installed. (The actual password will be different from the example below.)

```bash
    > curl -LO -u source:eioVvn5U http://www.msg.chem.iastate.edu/GAMESS/download/source/gamess-current.tar.gz
```

Then create the machine and `ssh` into it. It will install dependencies and copy `gamess-current.tar.gz` into the home directory.

```bash
    > vagrant up && vagrant ssh
```

Once you're logged in, check that the provisioning was successful. Make sure the shared-memory settings have been updated, and that the source code is in the home folder.

```bash
    > cat /proc/sys/kernel/shmmax
    805306368
    > cat /proc/sys/kernel/shmall
    196608
    > cd ~
    > ls gamess-current.tar.gz
```

## Compiling the source code

Once your VM/container is ready, run the build script. 

    > ./build-gamess.sh

It will extract the source code from `gamess-current.tar.gz` into `~/gamess` and then run the script `gamess/config`. 

The script is interactive and requires specific input from you. If you're starting with a `trusty64` box and the original provisioning script, your answers *should* be as below. The script should offer the equivalent of `~/gamess` as the default GAMESS and build directories.

- target machine name: `linux64`
- GAMESS directory: *(accept the default)*
- build directory: *(accept the default)*
- version: *(accept the default)*
- compiler: `gfortran`
- version: `4.8`
- math library: `atlas`
- math location: `/usr/lib/atlas-base`
- communication: `sockets`
- try LIBCCHEM?: `no`

The script will compile the code, which should take 20-30 minutes. It should finish with the line:

    The linking of GAMESS to binary gamess.00.x was successful.

It will then run a battery of tests. You should get the message `GAMESS passed 47 of 47 tests` after several minutes.

The script archives `gamess` as `gamess-built.tar.gz` for future use. If using Cloud9, you can download the archive by right-clicking on it in the file list and selecting `Download`. If using Vagrant, move the archive into `/vagrant`, which syncs with the directory `build-gamess/` on your host operating system. 

    > mv gamess-built.tar.gz /vagrant/


## Testing the build

Try using the `rungms` script yourself. If you have a display set, try viewing the output using jmol. (Currently doesn't work on Cloud9 unless you install `novnc`, coming later.)

    > bash
    > cp gamess/tests/standard/exam01.inp ./
    > rungms exam01.inp > exam01.log
    > jmol exam01.log

Done!

