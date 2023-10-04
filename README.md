# Carvel ytt rules for Bazel

## Setup

Add to `WORKSPACE` file.
```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# The actual snippet see in Releases.
http_archive(
    name = "rules_ytt",
    sha256 = "<sha256>",
    strip_prefix = "rules_ytt-X.Y.Z",
    urls = [
        "https://github.com/ekhabarov/rules_ytt/releases/download/vX.Y.X/rules_ytt-X.Y.Z.zip",
    ],
)

load("@rules_ytt//ytt:repositories.bzl",
  "rules_ytt_dependencies",
  "ytt_register_toolchains",
)

rules_ytt_dependencies()

ytt_register_toolchains()
```

## Usage

Add to `BUILD` file:

```starlark
load("@rules_ytt//:defs.bzl", "ytt")

# Build an image with rules_docker

load("@io_bazel_rules_docker//go:image.bzl", "go_image")

go_image(
    name = "image",
    srcs = ["main.go"],
    importpath = "...",
)

# or with rules_oci

load("@rules_oci//oci:defs.bzl", "oci_image")

oci_image(
    name = "image",
    ...
)

# Generate YAML manifests

ytt(
    name = "manifests",
    srcs = [
        ":base.yaml",
        ":defaults.yaml",
        ":values.yaml",
    ],
    # or
    # srcs = glob(["*.yaml"]),
    image = ":image.digest",
)
```

Which is equivalent to

```shell
ytt -f base.yaml -f defaults.yaml -f values.yaml --dangerous-allow-all-symlink-destinations
```

* `bazel build //:manifests` - generates yaml files and store it in cache.
* `bazel run //:manifests` - prints generated yaml files to stdout.
* `bazel run //:manifests | kubectl -n <namespace> -f -` - applies generated manifests to k8s cluster.

Image digest is available inside yaml templates as `data.values.image_digest`.

## LICENSE

   Copyright 2023 eBay Inc. Developer: Evgeny Khabarov

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   See [LICENSE](./LICENSE) for more details.
