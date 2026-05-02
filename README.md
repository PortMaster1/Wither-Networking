# Wither-Networking
This is my attempt at building a package managwr and packages for CraftyOS.

To build your own packages you will need:
- To put each package in its own folder inside your repository.
- Add your repository to your mirrorlist at `filepath`.
- Include a PKGBUILD.json file in the main folder of your package.


## PKGBUILD.json
The PKGBUILD.json file is what tells packy what your package depends on and where to put the package files.
It is formatted as such:
```json
{
    "deps": ["pkg1","pkg2"]
    "paths": {
        "README.md": "/etc/pkgname/README.md"
    }
}
```
- `deps` [optional]:
    - An array of package names that your package depends on
- `paths` [required]:
    - A dictionary of paths that your package files need to go to in the format of
        --- key: repository path
        --- value: desired system path