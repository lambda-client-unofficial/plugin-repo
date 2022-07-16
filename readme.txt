Each plugin have its own folder, and the folder naming must follow kebab-case.

In each folder, there will be three files:
    build
    source
    version

The build file will contain the script that will be executed inside the cloned directory in order to build the plugin file.
The resulting jar must be in the build/libs directory inside the cloned directory.

The source file contains the link to the git repo that will be cloned.

The version file is split into 2 fields by space: the first field is the version of the plugin, and the second field is the version of lambda API that the plugin used.
The version file is needed later for integration with other clients.
