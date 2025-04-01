def _impl(ctx):
  ytt = ctx.toolchains["//ytt:toolchain_type"]

  args = ctx.actions.args()
  args.add("--dangerous-allow-all-symlink-destinations")

  for f in ctx.files.srcs:
    args.add("-f", f.path)

  for f in ctx.files.data_values_file:
    args.add("--data-values-file", f.path)

  for k, v in ctx.attr.data_value_file.items():
    args.add("--data-value-file", "{key}={path}".format(key=k, path=v.files.to_list()[0].path))

  for v in ctx.attr.data_value_yaml:
    args.add("--data-value-yaml", v)

  manifest = ctx.actions.declare_file(ctx.label.name + ".yaml")

  ctx.actions.run_shell(
    inputs = ctx.files.srcs + ctx.files.data_values_file + ctx.files.data_value_file,
    outputs = [manifest],
    arguments = [args],
    command = "{ytt} $@ > {manifest}".format(
      ytt = ytt.ytt_info.binary.path,
      manifest = manifest.path,
    ),
    tools =  [ytt.ytt_info.binary],
  )

  sh = ctx.actions.declare_file("{}_render.sh".format(ctx.label.name))

  ctx.actions.write(
    output = sh,
    content = "cat {}".format(manifest.short_path),
    is_executable = True,
  )

  return [DefaultInfo(
    files = depset([manifest]),
    runfiles = ctx.runfiles(files = [manifest]),
    executable = sh,
  )]

ytt = rule(
  implementation = _impl,
  attrs = {
    "srcs": attr.label_list(
      allow_files = True,
      mandatory = True,
      doc = """List of files that will be passed to `ytt` with `-f` parameter.

      It could be `*.yaml` files as well as any other files which can be read
      later form inside yaml template with
      [data.read](https://carvel.dev/ytt/docs/v0.51.x/lang-ref-ytt/#data)
      Starlark function. See [examples](/examples) for details.
      """
    ),
    "data_values_file": attr.label_list(
        allow_files = True,
        doc = "Set multiple data values via plain YAML files. See [examples/data_values](/examples/data_values) for details.",
    ),
    "data_value_file": attr.string_keyed_label_dict(
        allow_files = True,
        doc = """Set specific data value to contents of source or generated file. See [examples/data_values](/examples/data_values) for details.""",
    ),
    "data_value_yaml": attr.string_list(
        doc = "Set specific data value to given value, parsed as YAML. See [examples/data_values](/examples/data_values) for details.",
    ),
  },
  toolchains = ["//ytt:toolchain_type"],
  executable = True,
)
