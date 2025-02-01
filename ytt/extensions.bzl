load("//ytt:repositories.bzl", "rules_ytt_register_toolchains")
load("//ytt/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")

def _toolchains_impl(mctx):
    for mod in mctx.modules:
        ytt = mod.tags.ytt[0]

    rules_ytt_register_toolchains(
        name = ytt.name,
        version = ytt.version,
        register = False,
    )

toolchains = module_extension(
    implementation = _toolchains_impl,
    tag_classes = {
        "ytt": tag_class(attrs = {
            "name": attr.string(default = "ytt"),
            "version": attr.string(default = "0.46.2")},
        ),
    },
)
