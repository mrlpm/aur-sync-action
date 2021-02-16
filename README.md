# AUR sync action

This action can sync an AUR package with Github release.


## Requirements

You should add to your secrets an SSH private key that match your key uploaded to your AUR account,
so this action can commit and push to it.


## Inputs

### `package_name`
**Required** The AUR package name you want to update.

### `github_repo`
**Required** The GitHub repo you want to sync with.

### `commit_username`
**Required** The username to use when creating the new commit.

### `commit_email`
**Required** The email to use when creating the new commit.

### `ssh_private_key`
**Required** Your private key with access to AUR package.

### `extra_dependencies`
A string that contains extra dependencies when building the AUR package, separated by space.

## Example usage
```
name: aur-sync

on:
  schedule:
    - cron: '0 0 * * *'

jobs:
  aur-sync:
    runs-on: ubuntu-latest
    steps:
      - name: Sync AUR package with Github release
        uses: dbinary/aur-sync-action@v1.2
        with:
          package_name: logism-evolution
          github_repo: 'reds-heig/logisim-evolution'
          commit_username: 'Github Action Bot'
          commit_email: github-action-bot@example.com
          ssh_private_key: ${{ secrets.AUR_SSH_PRIVATE_KEY }}
          extra_dependencies: 'jre-openjdk'
```
