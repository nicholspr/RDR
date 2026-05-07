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

You can override the defaults if the host or target path changes:

```powershell
.\deploy.ps1 -HostName rdr.nichsoft.io -UserName root -RemotePath /docker/rdr/site -SiteUrl https://rdr.nichsoft.io
```

The script uploads [index.html](c:\DATA\GIT\RDR\index.html) and [styles.css](c:\DATA\GIT\RDR\styles.css) to the remote path over SSH and then checks the public URL.

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
