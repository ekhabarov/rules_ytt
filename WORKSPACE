workspace(name = "rules_ytt")

load("//ytt:repositories.bzl",
  "rules_ytt_dependencies",
  "rules_ytt_internal_dependencies",
  "rules_ytt_register_toolchains",
)

rules_ytt_dependencies()

rules_ytt_internal_dependencies()

rules_ytt_register_toolchains()

load("@aspect_bazel_lib//lib:repositories.bzl", "aspect_bazel_lib_dependencies", "aspect_bazel_lib_register_toolchains")

aspect_bazel_lib_dependencies()

aspect_bazel_lib_register_toolchains()

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

