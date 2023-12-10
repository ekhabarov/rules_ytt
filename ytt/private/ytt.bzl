def _impl(ctx):
  ytt = ctx.toolchains["//ytt:toolchain_type"]

  args = ctx.actions.args()
  args.add("--dangerous-allow-all-symlink-destinations")

  for f in ctx.files.srcs:
    args.add("-f", f.path)

  manifest = ctx.actions.declare_file(ctx.label.name + ".yaml")

  ctx.actions.run_shell(
    inputs = ctx.files.srcs,
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
      [data.read](https://carvel.dev/ytt/docs/v0.46.x/lang-ref-ytt/#data)
      Starlark function. See [examples](/examples/minimal) for details.
      """
    ),
  },
  toolchains = ["//ytt:toolchain_type"],
  executable = True,
)

