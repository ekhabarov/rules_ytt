# Carvel ytt rules for Bazel

## Setup

See [releases](https://github.com/ekhabarov/rules_ytt/releases).

## Usage

Add to `BUILD` file:

```starlark
load("@rules_ytt//:defs.bzl", "ytt")

# Build an image with rules_docker

load("@io_bazel_rules_docker//container:container.bzl", "container_image")

container_image(
    name = "image",
    ...
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
        ":image.digest",
    ],
    # or
    # srcs = glob(["*.yaml"]) + [":image.digest"],
)
```

Which is equivalent to

```shell
ytt \
    -f base.yaml \
    -f defaults.yaml \
    -f values.yaml \
    -f image.json.sha256, # file created by "image.digest" target
    --dangerous-allow-all-symlink-destinations
```

Inside YAML template digest can be used like this:

```yaml
#@ load("@ytt:data", "data")
---
image: #@ "repo/image@" + data.read("image.json.sha256").strip()
```
### Commands

* `bazel build //:manifests` - generates YAML files and retains them in cache.
* `bazel run //:manifests` - prints generated YAML files to stdout.
* `bazel run //:manifests | kubectl -n <namespace> -f -` - applies generated manifests to k8s cluster.

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
