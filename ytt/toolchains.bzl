"""This module implements the Ytt toolchain rule.
"""

load("//ytt:providers.bzl", "YttInfo")

def _ytt_toolchain_impl(ctx):
    binary = ctx.executable.ytt
    template_variables = platform_common.TemplateVariableInfo({
        "YTT_BIN": binary.path,
    })
    default = DefaultInfo(
        files = depset([binary]),
        runfiles = ctx.runfiles(files = [binary]),
    )
    ytt_info = YttInfo(
        binary = binary,
    )
    # Export all the providers inside our ToolchainInfo
    # so the resolved_toolchain rule can grab and re-export them.
    toolchain_info = platform_common.ToolchainInfo(
        ytt_info = ytt_info,
        template_variables = template_variables,
        default = default,
    )
    return [
        default,
        toolchain_info,
        template_variables,
    ]

ytt_toolchain = rule(
    implementation = _ytt_toolchain_impl,
    attrs = {
        "ytt": attr.label(
            doc = "A hermetically downloaded executable target for the target platform.",
            mandatory = False,
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
        "version": attr.string(mandatory = True, doc = "Version of the Ytt binary")
    },
    doc = """Defines a ytt runtime toolchain.

For usage see https://docs.bazel.build/versions/main/toolchains.html#defining-toolchains.
""",
)
