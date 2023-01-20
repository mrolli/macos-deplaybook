# Full Mac Setup Process

Although a lot of things can be automated, there are cases where this is not
possible, i.e. chicken-egg issues, or not worth the effort. Therefore manual steps
are needed. These are outlined here:

## Initial configuration of a Brand New Mac

Before starting, I completed Apple's mandatory macOS setup wizard that includes

- creating a local user account
- (optionally) signing into my iCloud account
- (optionally) setting up stuff like Touch ID

Once on the desktop of my freshly installed Mac is ready:

- Clone this very repo and run the `bootstrap` command. This will install Command Line Tools and Ansible
- Sign in in App Store since mas can't sign in automatically and the setup wizard did not do that
- Run the playbook `main.yml` with `--skip-tags post`.
- Start Synchronization tasks:
  - Open Photos and make sure iCloud sync options are correct
  - Open Music, make sure computer is authorized, and set Library sync options
- Configure github.com authentication for gh and git
  - Run `gh auth login` and follow the https procedure
  - Copy `~/.gnupg` from another device for the time being # TODO: Put this in 1password and dotfiles
- Install old-fashioned apps if required
  - Microsoft Office
      - fetch latest from https://portal.office.com
      - see also the [KB article](https://serviceportal.unibe.ch/sp?id=kb_article_view&sys_kb_id=b0d605bedb50901078ed3e482296199e)
      - Start Word for the first time and login to M365 to activate Office
  - Forticlient
    - fetch [latest FortiClient](https://secdl.unibe.ch/FortiClientVPNSetup-MacOSX-current.dmg)
    - follow this [KB article](https://serviceportal.unibe.ch/sp?id=kb_article_view&sys_kb_id=3f0029691b005050134ddc6a9b4bcb26)
- Manual settings to automate someday:
  - Safari:
    - activate additional extensions: AdGuard, Total Refresh, Vimari
- When all resources are available: Run the playbook `main.yml` with `--tags post` to complete the setup
