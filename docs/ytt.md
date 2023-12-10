<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="ytt"></a>

## ytt

<pre>
ytt(<a href="#ytt-name">name</a>, <a href="#ytt-srcs">srcs</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ytt-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ytt-srcs"></a>srcs |  List of files that will be passed to <code>ytt</code> with <code>-f</code> parameter.<br><br>      It could be <code>*.yaml</code> files as well as any other files which can be read       later form inside yaml template with       [data.read](https://carvel.dev/ytt/docs/v0.46.x/lang-ref-ytt/#data)       Starlark function. See [examples](/examples/minimal) for details.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |


