# Sysrepo development setup

* Installation
* Execution
* Sysrepo plugin development
* Cleanup

# Installation

To install the sysrepo, Netopeer2, libyang and their dependecies run either of the two scripts:
 * setup-dev-sysrepo.sh, or
 * setup-dev-sysrepo-legacy.sh

Depending on the verisoin of sysrepo, Netopeer2, libyang and their dependencies you run one of the above two scripts. The `setup-dev-sysrepo.sh` script is for the Sysrepo version 1.0.0 and above, while the `setup-dev-sysrepo-legacy.sh` script is for Sysrepo version 0.7.9 and below.

Both scripts take the directory location of all the applications relatied to Sysrepo as an argument. An example is shown below:
> setup-dev-sysrepo.sh /tmp/sysrepofs \
> setup-dev-sysrepo-legacy.sh /tmp/sysrepofs

# Execution

To execute the sysreo, Netopeer2 application you need to modify the `LD_LIBRARY_PATH` as well as the `PATH` environmet variables so that the shell can find the CLI tools that are installed in a non-standard location.

The applications can be run either in root space or in user space. If you run the application in the root space you need to make sure that the variables are visible in root space too. Ona way is to specify the variables before the command you are executing.

Note, `PATH` varibale is shared between root and user space but `LD_LIBRARY_PATH` is not.

Example of running the application in user space are shown below:

> export PATH=$PATH:/tmp/sysrepofs/bin \
> export LD_LIBRARY_PATH="/tmp/sysrepofs/lib;/lib" \
> \
> netopeer2-server -d &

Example of running the application in root space are shown below:

> export PATH=$PATH:/tmp/sysrepofs/bin \
> \
> sudo LD_LIBRARY_PATH="/tmp/sysrepofs/lib;/lib" netopeer2-server -d &

# Sysrepo plugin development

The scripts `setup-dev-sysrepo.sh` and `setup-dev-sysrepo-legacy.sh` will download all the sysrepo plugins for the Sartura GitHub and compile them. To install additional files that are used for developent use scripts:
 * setup-dev-files.sh, used to install UCI and ubus files
 * setup-dev-systemd-services.sh, used for seting up systemd services for ubus and rpcd

This scripts should are run after the `setup-dev-sysrepo.sh` or `setup-dev-sysrepo-legacy.sh` scirpts and the directory for installing the files should be the same as the one used in the
`setup-dev-sysrepo.sh` or `setup-dev-sysrepo-legacy.sh` scirpt.


Usage example is shown bellow:

> setup-dev-files.sh /tmp/sysrepofs/repositories/plugins \
> setup-dev-systemd-services.sh /tmp/sysrepofs [legacy]

The optional `legacy` flag indicates if the systemd services are for the Sysrepo version 0.7.9 and below.

This part of the section will discuss how to setup the debugger in VSCode editor. Edit the `launch.json` file in the following way.

```
...
            "externalConsole": false,
            "MIMode": "gdb",
			"environment": [
                {
                    "name": "LD_LIBRARY_PATH",
                    "value": "/opt/sysrepofs/lib"
                },
                {
                    "name": "PATH",
                    "value": "$PATH:/opt/sysrepofs/bin"
                }
            ],
...

```

In the case of running the plugin in root space use the generated `gdbp` script which calles the gdb CLI tool in root space and passes all given arguments to `gdb` CLI tool. To use the `gdbp` instead of `gdb` in VSCode, edit the `launch.json` in the followin way:

```
...
            "externalConsole": false,
            "miDebuggerPath": "/tmp/sysrepofs/gdbp",
            "MIMode": "gdb",
			"environment": [
                {
                    "name": "LD_LIBRARY_PATH",
                    "value": "/opt/sysrepofs/lib"
                },
                {
                    "name": "PATH",
                    "value": "$PATH:/opt/sysrepofs/bin"
                }
            ],
...

```

# Cleanup

To clean up the sysrepo directory where all the applications and files are stored use on of the scripts:
 * setup-dev-clean.sh, for Sysrepo version 1.0.0 and above
 * setup-dev-clean-legacy.sh, for Sysrepo version 0.7.9 and below