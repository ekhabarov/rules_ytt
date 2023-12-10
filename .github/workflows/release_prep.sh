#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${1}
# The prefix is chosen to match what GitHub generates for source archives
# This guarantees that users can easily switch from a released artifact to a source archive
# with minimal differences in their code (e.g. strip_prefix remains the same)
PREFIX="rules_ytt-${TAG:1}"
ARCHIVE="rules_ytt-$TAG.tar.gz"

# NB: configuration for 'git archive' is in /.gitattributes
git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip > $ARCHIVE
SHA=$(shasum -a 256 $ARCHIVE | awk '{print $1}')

cat << EOF
Paste this snippet into your `WORKSPACE.bazel` file:

\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_ytt",
    sha256 = "${SHA}",
    strip_prefix = "${PREFIX}",
    url = "https://github.com/ekhabarov/rules_ytt/releases/download/${TAG}/${ARCHIVE}",
)

load("@rules_ytt//ytt:repositories.bzl", "rules_ytt_dependencies", "rules_ytt_register_toolchains")

rules_ytt_dependencies()

rules_ytt_register_toolchains()
\`\`\`
EOF
