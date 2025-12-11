# dotfiles
Collection of dotfiles
## Setting up on a new machine
To set up a new machine to use your version controlled config files, all you need to do is to clone the repository on your new machine telling git that it is a bare repository:
```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/adrianveen/dotfiles.git ~
```
However, some programs create default config files, so this might fail if git finds an existing config file in your `$HOME`. In that case, a simple solution is to clone to a temporary directory, and then delete it once you are done:
```bash
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/adrianveen/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
```

## Power Shell Profile
- Made with the help of claude
<img width="867" height="523" alt="powershell-profile" src="https://github.com/user-attachments/assets/89a26675-d800-409a-8343-4e575095ea84" />

- Only drive letter and immediate parent dir are showng along with cwd
<img width="888" height="564" alt="truncated-path" src="https://github.com/user-attachments/assets/b873e747-732a-4699-b1e9-7d7e0de5d112" />


