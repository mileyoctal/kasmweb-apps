![alt text](img/kasm_logo.png  "Kasm Logo")

Kasm is a Desktop and Application Isolation Platform. It empowers users to run temporary computing environments safely in a containerized environment - building a "Chasm" between the user and the threats born on the web. 

End users conveniently access the Kasm UI and containers "Kasms" via any modern browser.

This repo services as a distribution point for Kasm Server.

Please see [kasmweb.com](https://www.kasmweb.com) for more details.


### UI
![alt text](img/kasm_dashboard.png "Kasm's UI Dashboard")

### A "Kasm"
![alt text](img/kasm_desktop.png  "A view of a Kasm")


# Installation

The entire Kasm stack can be installed on a single *nix machine. Simply [Download](https://bitbucket.org/kasmtech/kasm_release/downloads/) , extract and install.
Instructions can be found [Here](https://www.kasmweb.com/docs/latest/index.html).
 

# Creating a Custom Kasm Image

Kasm Server allows administrators to build and using custom Docker Images within the application.  This repository contains
several example dockerfile, that server as examples.

For containers to work in Kasm server they must be build from  a [kasmweb/core](https://hub.docker.com/r/kasmweb/core) base container.

To build the provided containers:


    sudo docker build -t kasmweb/desktop:dev -f dockerfile-kasm-desktop .
    sudo docker build -t kasmweb/firefos:dev -f dockerfile-kasm-firefox .
    sudo docker build -t kasmweb/firefos:dev -f dockerfile-kasm-chrome .



# Submitting a Ticket

When submitting a ticket, please include the following details so we can assist you better:

-   Database Version (Available via the System Info Page)
-   API Server Build (Available via the System Info Page)
-   Kasm docker image and tag if applicable


# Quick Links

-   To download the latet Kasm Server release, head over to the [Download](https://bitbucket.org/kasmtech/kasm_release/downloads/) download page.
-   If you are having an issue, please [Submit a Ticket](https://bitbucket.org/kasmtech/kasm_release/issues?status=new&status=open)
-   Review the [Documentation](https://www.kasmweb.com/docs/latest/index.html)
-   Visit our main site: [kasmweb.com](https://www.kasmweb.com)
