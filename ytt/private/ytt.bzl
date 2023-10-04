def _impl(ctx):
  ytt = ctx.toolchains["//ytt:toolchain_type"]
  runtools = []
  dv = []
  runfiles = ctx.runfiles()

  if ctx.file.image:
    image_digest = ctx.actions.declare_file("image_digest.out")

    ctx.actions.run_shell(
      inputs = [ctx.file.image],
      outputs = [image_digest],
      command = "sed -e 's/^/image_digest: /g' {} > {}".format(ctx.file.image.path, image_digest.path),
    )

    runfiles = runfiles.merge(ctx.runfiles(files = [ctx.file.image, image_digest]))
    runtools = [image_digest]
    dv = ["--data-values-file", image_digest.path]

  yttargs = ctx.actions.args()
  yttargs.add("--dangerous-allow-all-symlink-destinations")
  yttargs.add_all("", dv)

  for f in ctx.files.srcs:
    yttargs.add("-f", f.path)

  manifest = ctx.actions.declare_file(ctx.label.name + ".yaml")

  ctx.actions.run_shell(
    inputs = ctx.files.srcs,
    outputs = [manifest],
    arguments = [yttargs],
    command = "{ytt} $@ > {manifest}".format(
      ytt = ytt.ytt_info.binary.path,
      manifest = manifest.path,
    ),
    tools =  [ytt.ytt_info.binary] + runtools,
  )

  sh = ctx.actions.declare_file("{}_render.sh".format(ctx.label.name))

  ctx.actions.write(
    output = sh,
    content = "cat {}".format(manifest.short_path),
    is_executable = True,
  )

  return [DefaultInfo(
    files = depset([manifest]),
    runfiles = runfiles.merge(ctx.runfiles(files = [manifest])),
    executable = sh,
  )]

ytt = rule(
  implementation = _impl,
  attrs = {
    "srcs": attr.label_list(
      allow_files = True,
      mandatory = True,
      doc = "List of files that will be passed to ytt with -f param.",
    ),
    "image": attr.label(
      allow_single_file = True,
      doc = "(DEPRECATED) Target that generates a Docker image. Used for extracting image digest.",
    ),
  },
  toolchains = ["//ytt:toolchain_type"],
  executable = True,
)

