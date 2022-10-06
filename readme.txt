For users:
To download the built plugins, go to the releases page.
https://github.com/lambda-client-unofficial/plugin-repo/releases
Or, you can also download from the github actions for the plugins that are built on the latest commit
https://github.com/lambda-client-unofficial/plugin-repo/actions/workflows/latest.yml


For Developers:
Each plugin have its own folder, and the folder naming must follow kebab-case.
In each folder, there will be three files:
    build
    source
    version
The build file will contain the script that will be executed inside the cloned directory in order to build the plugin file.
The resulting jar must be in the build/libs directory inside the cloned directory.
The source file contains the link to the git repo that will be cloned.
The version file is split into 2 fields by space: the first field is the tag/version of the plugin that the build script will checkout, and the second field is the version of lambda API that the plugin used.
