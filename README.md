# RDR

A website to monitor the operational status and capacity of an Urgent & Emergency Network.

## Current State

- Static holding page for the RDR platform
- Live placeholder deployed at https://rdr.nichsoft.io
- PowerShell deployment script for SSH publishing

## Getting Started

### Prerequisites

- PowerShell 5.1 or later
- SSH client and SCP available on your machine
- Access to the target VPS

### Local Preview

```bash
start index.html
```

### Deployment

```powershell
.\deploy.ps1
```

To force a specific SSH private key:

```powershell
.\deploy.ps1 -IdentityFile $HOME\.ssh\id_rsa
```

You can override the defaults if the host or target path changes:

```powershell
.\deploy.ps1 -HostName rdr.nichsoft.io -UserName root -RemotePath /docker/rdr/site -SiteUrl https://rdr.nichsoft.io -IdentityFile $HOME\.ssh\id_rsa
```

The script uploads [index.html](c:\DATA\GIT\RDR\index.html) and [styles.css](c:\DATA\GIT\RDR\styles.css) to the remote path over SSH and then checks the public URL.

### Key-Based SSH Setup

The local machine already has a public key at `$HOME\.ssh\id_rsa.pub`. To allow non-interactive deployment, add that key to the server user's `authorized_keys` file from an authenticated SSH session:

```sh
mkdir -p ~/.ssh && chmod 700 ~/.ssh && printf '%s\n' 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCosHAQCPG2n116H+fOqfQDuTF6gFwn6u0/VrnpZodFWFw5odw3A17hE8ZfVWM+Gmqx15lASgSXVGoss80elOUfIQK3OUnfRYXAgC2W0ZD8eik3Xfxp4tQh4SrCNTm5Dvjc4Nryq/ZFJzBG5AfbCyk138OPggWCYT55ltqPCf7p7az+ywS/gTRQBlOpjPRXgj72s+/aJHyTRvCHzIgiWwdi7iHlOmEMosQCV69eqsyceB17B54hSM9Rd4ewsEYUl3LmRgSod8SaL/6n2LvnKAHZ/2KkVgw2ba5XicsVHuCPDxucc0M3CcbExtxxSUHwnSZSgLsPLPkjBunYelbT8zUpoAdvPSZDDdcIP6j05SzRXtbcSU1hndLnI77nJOp27Yrpb4NRPFpQVlHTtn5s5LyR+UMOX7jhjOvUmyoFwKyN3o6e5cQuqLP9sTULA+jRLbihoAymz8j2GIa2VEOON/6winz9WKD+hxOatrPsoI+uNpkYqinz8RFV3b6cCRCFhVDiDxzApXXvuLWywS+eygk5SwkpJSxT6ugqajn91bRh5kjW4BN/vjeOzc85gFcBN8RdTbBGk9A4bTl6yV0BhMWjBYrYny2OdFluxpL/uuvG5dKSXwPO6TkU9zlNWU7KcxPZOM4xSSI2ux8So4j+8X2T+04d3+ScSH+iRMHIpy/7Aw== nicho@PNAIPC' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
```

After that, test access from this machine with:

```powershell
ssh -i $HOME\.ssh\id_rsa root@rdr.nichsoft.io "echo ok"
```

## Project Files

```
RDR/
├── deploy.ps1
├── index.html
└── README.md
└── styles.css
```

## License

MIT
