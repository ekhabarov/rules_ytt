<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies

<a id="rules_ytt_register_toolchains"></a>

## rules_ytt_register_toolchains

<pre>
load("@rules_ytt//ytt:repositories.bzl", "rules_ytt_register_toolchains")

rules_ytt_register_toolchains(<a href="#rules_ytt_register_toolchains-name">name</a>, <a href="#rules_ytt_register_toolchains-version">version</a>, <a href="#rules_ytt_register_toolchains-register">register</a>, <a href="#rules_ytt_register_toolchains-kwargs">kwargs</a>)
</pre>

Convenience macro for users which does typical setup.

- create a repository for each built-in platform like `ytt_linux_amd64` -
  this repository is lazily fetched when node is needed for that platform.
- create a repository exposing toolchains for each platform like
  `ytt_platforms`
- register a toolchain pointing at each platform Users can avoid this
  macro and do these steps themselves, if they want more control.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rules_ytt_register_toolchains-name"></a>name |  base name for all created repos, like "ytt"   |  `"ytt"` |
| <a id="rules_ytt_register_toolchains-version"></a>version |  Ytt tool version. Supported versions are listed in [versions.bzl](/ytt/private/versions.bzl).   |  `"0.46.2"` |
| <a id="rules_ytt_register_toolchains-register"></a>register |  Register toolchain. Should be `False` with bzlmod.   |  `True` |
| <a id="rules_ytt_register_toolchains-kwargs"></a>kwargs |  passed to each node_repositories call   |  none |


<a id="ytt_repositories"></a>

## ytt_repositories

<pre>
load("@rules_ytt//ytt:repositories.bzl", "ytt_repositories")

ytt_repositories(<a href="#ytt_repositories-name">name</a>, <a href="#ytt_repositories-platform">platform</a>, <a href="#ytt_repositories-repo_mapping">repo_mapping</a>, <a href="#ytt_repositories-ytt_version">ytt_version</a>)
</pre>

Fetch external tools needed for ytt_toolchain

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ytt_repositories-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ytt_repositories-platform"></a>platform |  -   | String | required |  |
| <a id="ytt_repositories-repo_mapping"></a>repo_mapping |  In `WORKSPACE` context only: a dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.<br><br>For example, an entry `"@foo": "@bar"` declares that, for any time this repository depends on `@foo` (such as a dependency on `@foo//some:target`, it should actually resolve that dependency within globally-declared `@bar` (`@bar//some:target`).<br><br>This attribute is _not_ supported in `MODULE.bazel` context (when invoking a repository rule inside a module extension's implementation function).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | optional |  |
| <a id="ytt_repositories-ytt_version"></a>ytt_version |  -   | String | required |  |


