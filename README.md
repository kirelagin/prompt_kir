This is a prompt theme for [Zsh][zsh]. It is heavily based on adam2 by [Adam Spiers][adam].

# Installation

Just `source prompt_kir.zsh` from your `.zshrc`.


# Looks

This theme looks totally like adam2 but has a number of enhancements:

 * The code is readable (I hope).
 * Resizes dynamically on the terminal window resize.
 * Arrow on the left doesn't look ugly in UTF-8 mode.
 * When you are root, arrow turns into `#` and there are more bright red colours around.
 * Hostname on the right is bold while the `@` is not.
 * Lines are white by default.

Default colours are green for current directory and cyan for username and hostname:

![Prompt](https://raw.githubusercontent.com/kirelagin/prompt_kir/gh-pages/prompt.png)

![Root prompt](https://raw.githubusercontent.com/kirelagin/prompt_kir/gh-pages/prompt_root.png)


## Distro- and host-specific colours

Each my machine has a global variable `$DISTRO_COLOUR`.
For example, machines running Gentoo have this variable set to `12` (blue)
while on Debian I set it to `15` (white).

Also, all my servers have associated colours (in fact, their hostnames are derived from those colours).
`$HOST_COLOUR` tells the colour of a server and on non-servers it is set to `15` (white).

So, the theme makes use of those variables: if they are set, it will use `$DISTRO_COLOUR` for
the colour of the current directory on the left and `$HOST_COLOUR` for username and hostname on the right.

Here is the prompt of my laptop:

![kirNote prompt](https://raw.githubusercontent.com/kirelagin/prompt_kir/gh-pages/prompt_kirNote.png)


 [zsh]:         http://www.zsh.org/
 [adam]:        http://adamspiers.org/computing/zsh/
