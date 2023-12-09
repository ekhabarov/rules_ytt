<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies


<a id="ytt_repositories"></a>

## ytt_repositories

<pre>
ytt_repositories(<a href="#ytt_repositories-name">name</a>, <a href="#ytt_repositories-platform">platform</a>, <a href="#ytt_repositories-repo_mapping">repo_mapping</a>, <a href="#ytt_repositories-ytt_version">ytt_version</a>)
</pre>

Fetch external tools needed for ytt toolchain

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ytt_repositories-name"></a>name |  A unique name for this repository.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ytt_repositories-platform"></a>platform |  -   | String | required |  |
| <a id="ytt_repositories-repo_mapping"></a>repo_mapping |  A dictionary from local repository name to global repository name. This allows controls over workspace dependency resolution for dependencies of this repository.&lt;p&gt;For example, an entry <code>"@foo": "@bar"</code> declares that, for any time this repository depends on <code>@foo</code> (such as a dependency on <code>@foo//some:target</code>, it should actually resolve that dependency within globally-declared <code>@bar</code> (<code>@bar//some:target</code>).   | <a href="https://bazel.build/rules/lib/dict">Dictionary: String -> String</a> | required |  |
| <a id="ytt_repositories-ytt_version"></a>ytt_version |  -   | String | required |  |


<a id="http_archive"></a>

## http_archive

<pre>
http_archive(<a href="#http_archive-name">name</a>, <a href="#http_archive-kwargs">kwargs</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="http_archive-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="http_archive-kwargs"></a>kwargs |  <p align="center"> - </p>   |  none |


<a id="rules_ytt_dependencies"></a>

## rules_ytt_dependencies

<pre>
rules_ytt_dependencies()
</pre>

rules_ytt runtime dependencies.



<a id="rules_ytt_internal_dependencies"></a>

## rules_ytt_internal_dependencies

<pre>
rules_ytt_internal_dependencies()
</pre>

rules_ytt dependencies for internal use only.



<a id="rules_ytt_register_toolchains"></a>

## rules_ytt_register_toolchains

<pre>
rules_ytt_register_toolchains(<a href="#rules_ytt_register_toolchains-name">name</a>, <a href="#rules_ytt_register_toolchains-version">version</a>, <a href="#rules_ytt_register_toolchains-kwargs">kwargs</a>)
</pre>

Convenience macro for users which does typical setup.

- create a repository for each built-in platform like `ytt_linux_amd64` -
  this repository is lazily fetched when node is needed for that platform.
- create a repository exposing toolchains for each platform like `ytt_platforms`
- register a toolchain pointing at each platform
Users can avoid this macro and do these steps themselves, if they want more control.


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="rules_ytt_register_toolchains-name"></a>name |  base name for all created repos, like "ytt"   |  <code>"ytt"</code> |
| <a id="rules_ytt_register_toolchains-version"></a>version |  Ytt tool version. Supported versions are listed in <code>ytt/private/versions.bzl</code>.   |  <code>"0.46.2"</code> |
| <a id="rules_ytt_register_toolchains-kwargs"></a>kwargs |  passed to each node_repositories call   |  none |


