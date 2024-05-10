# nfsserver

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nfsserver](#setup)
    * [What nfsserver affects](#what-nfsserver-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nfsserver](#beginning-with-nfsserver)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module manages the NFS server on OpenBSD.

## Module Description

This module configures the NFS server, including the nfsd, mountd, lockd, and statd services.
It configures the /etc/exports file, as well as allows you to manage the exported directories.

## Setup

### What nfsserver affects

* manages nfsd, mountd, statd, lockd services
* manages contents of /etc/exports file
* manages exported directories

### Setup Requirements **OPTIONAL**

The module depends on bodgit-portmap to configure portmap.

### Beginning with nfsserver

In the very simplest case, you just include the following:

```
include nfsserver
```

Configuration example for Hiera:

```
nfsserver::exports:
  export_node1:
    directory:
      '/export/node1':
        owner: 'root'
        group: '0'
        mode: '0755'
    exportparams: '-ro -mapall=nobody'
    clients: '-network=10.0.0 -mask=255.255.255.0'
  export_node2:
    directory:
      '/export/node2'
    exportparams: '-ro -mapall=nobody'
    clients: '-network=10.0.0 -mask=255.255.255.0'
```


## Usage

## Reference

## Limitations

This version works for OpenBSD NFS server.

## Development

Report issues or PRs at the GitHub repository here: https://github.com/buzzdeee/buzzdeee-nfsserver

