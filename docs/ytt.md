<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="ytt"></a>

## ytt

<pre>
load("@rules_ytt//:defs.bzl", "ytt")

ytt(<a href="#ytt-name">name</a>, <a href="#ytt-srcs">srcs</a>, <a href="#ytt-data_value_file">data_value_file</a>, <a href="#ytt-data_value_yaml">data_value_yaml</a>, <a href="#ytt-data_values_file">data_values_file</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ytt-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ytt-srcs"></a>srcs |  List of files that will be passed to `ytt` with `-f` parameter.<br><br>It could be `*.yaml` files as well as any other files which can be read later form inside yaml template with [data.read](https://carvel.dev/ytt/docs/v0.51.x/lang-ref-ytt/#data) Starlark function. See [examples](/examples) for details.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | required |  |
| <a id="ytt-data_value_file"></a>data_value_file |  Set specific data value to contents of source or generated file. See [examples/data_values](/examples/data_values) for details.   | Dictionary: String -> Label | optional |  `{}`  |
| <a id="ytt-data_value_yaml"></a>data_value_yaml |  Set specific data value to given value, parsed as YAML. See [examples/data_values](/examples/data_values) for details.   | List of strings | optional |  `[]`  |
| <a id="ytt-data_values_file"></a>data_values_file |  Set multiple data values via plain YAML files. See [examples/data_values](/examples/data_values) for details.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |


