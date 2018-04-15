Dotfiles
===

Add some alises to easily versioning the [dotfile][1] repository.

Based on the [The best way to store your dotfiles: A bare Git repository][2] article.

### Example

```
$ dotfiles status
$ dotfiles add .vimrc
$ dotfiles commit -m "Add vimrc"
$ dotfiles add .bashrc
$ dotfiles commit -m "Add bashrc"
$ dotfiles push
```

Authors
-------

*The authors of this module should be contacted via the [issue tracker][2].*

-   [Rogério R. Alcântara](https://github.com/roalcantara)

[1]: https://dotfiles.github.io/
[2]: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
