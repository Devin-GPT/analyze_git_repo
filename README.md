# analyze_git_repo
bash script for analyzing new git repos

- `cd ~`
- `mkdir bin`
- `git clone <repo-clone-url>`
- `cd analyze_git_repo mv analyze_git_repo.sh ../`
- `cd .. && rm -rf analyze_git_repo`
- `echo 'export PATH="$HOME/bin:$PATH"' >> ~/.zshrc`
- `chmod +x analyze_git_repo.sh`
- `analyze_git_repo /path/to/repo`
