load("//ytt:repositories.bzl", "rules_ytt_register_toolchains")
load("@bazel_features//:features.bzl", "bazel_features")

def _ext_impl(mctx):
    registrations = {}
    root_name = None
    for mod in mctx.modules:
        for t in mod.tags.toolchain:
            if mod.is_root:
                rules_ytt_register_toolchains( t.name, register = False, version = t.version)
                root_name = t.name
            elif t.name not in registrations.keys():
                registrations[t.name] = t

    for name, t in registrations.items():
        if name != root_name:
            rules_ytt_register_toolchains(name, register = False, version = t.version)

    if bazel_features.external_deps.extension_metadata_has_reproducible:
        return mctx.extension_metadata(reproducible = True)
    else:
        return None

ytt = module_extension(
    implementation = _ext_impl,
    tag_classes = {
        "toolchain": tag_class(attrs = {
            "name": attr.string(default = "ytt"),
            "version": attr.string(doc = "Version of ytt binary.")},
        ),
    },
)
