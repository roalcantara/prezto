# Yarn

Enhances the [Yarn][1] by providing a few aliases.

## Aliases

- `y` runs `yarn`
- `ya` runs `yarn add`
- `yb` runs `yarn build`
- `yl` runs `yarn lint`
- `yt` runs `yarn test`
- `ys` runs `yarn start`

## Functions

### yo - yarn outdated

- `yo` runs `yarn outdated --no-progress`

### yo deps - outdated dependencies

- `yo deps:scopes` prints `all outdated packages' scopes`
- `yo deps:packages` prints `all outdated packages`
- `yo deps` prints `all outdated dependencies`

### yo cmd - outdated dependencies commands

- `yo cmd:scopes` prints `all bump packages' scopes commands`
- `yo cmd:packages` prints `all bump packages' commands`
- `yo cmd` prints `all bump dependencies commands`

### yo bump - bump outdated dependencies

- `yo bump:scopes` bumps `all outdated packages' scopes`
- `yo bump:packages` bumps `all outdated packages`
- `yo bump` bumps `all outdated dependencies`

## Authors

*The authors of this module should be contacted via the [issue tracker][2].*

- [Rogério R. Alcântara](https://github.com/roalcantara)

[1]: https://yarnpkg.com/
[2]: https://github.com/roalcantara/prezto/issues
