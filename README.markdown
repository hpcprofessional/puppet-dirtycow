#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with dirtycow](#setup)
    * [What dirtycow affects](#what-dirtycow-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with dirtycow](#beginning-with-dirtycow)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module is to help the system administrator identify machines that are
currently susceptible to
[CVE-2016-5195](http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-5195),
commonly known as "Dirty COW".

For more information on this security threat, view the [Vulnerability Summary
for CVE-2016-5195](https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-5195).

## Module Description

This module creates a new fact named `cve_2016_5195`, that can be used to
determine if the system is vulnerable.

The administrator can determine how this information is handled during a
catalog compilation.

## Setup

### What dirtycow affects

* Creates a new ruby-based fact named `cve_2016_5195`.

### Beginning with dirtycow

Install the module:

```
puppet module install hpcprofessional/dirtycow
```

## Usage

After the module is installed, its reporting is activated simply by including
the class.

```
include dirtycow
```

Alternatively, parameters can be passed to the class by using the resource
syntax:

```
class { 'dirtycow':
  notify_behavior => 'fail',
}

## Reference

### Classes

`dirtycow`

This class makes use of the `cve_2016_5195` fact to notify the administrator.
The default behavior is simply to create a notification on the run. However, if
desired, the adminsitrator can set this class to fail the catalog compilation.

This is a parameterized class. The available parameters are shown here:

| Parameter       | Type | Values             | Default  |
| +-------------- | +--+ | +----------------- | +------+ |
| notify_behavior | Enum | `notify` or `fail` | `notify` |

### Facts

`cve_2016_5195`

This fact will have one of two several values based on the system:

| Value            | Meaning                                         |
| +--------------- | +---------------------------------------------- |
| `vulnerable`     | The system is vulnerable and should be patched. |
| `not vulnerable` | The system is not vulnerable.                   |
| `unknown`        | The state could not be determined. See below.   |

The final value, `unknown`, is returned when the fact could not determine
whether or not the system is affected. Generally, this is caused by the fact
being run on an unsupported operating system.

While this fact is automatically used by the `dirtycow` class, intrepid
administrators can find additional uses for it (e.g., using it to upgrade the
kernel on all affected machines via MCollective).

## Limitations


## Development

See the [Contribution Guidelines](CONTRIBUTING.md) to find out how you can help.
