# Copyright 2020 Plezentek, Inc. All rights reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "//wire/private:providers.bzl",
    "WireRelease",
)
load(
    "//wire/private/rules_go/lib:platforms.bzl",
    "PLATFORMS",
)

def _wire_toolchain_impl(ctx):
    release = ctx.attr.release[WireRelease]
    cross_compile = ctx.attr.goos != release.goos or ctx.attr.goarch != release.goarch
    return [platform_common.ToolchainInfo(
        name = ctx.label.name,
        cross_compile = cross_compile,
        default_goos = ctx.attr.goos,
        default_goarch = ctx.attr.goarch,
        actions = struct(),
        flags = struct(),
        release = release,
    )]

wire_toolchain = rule(
    _wire_toolchain_impl,
    attrs = {
        "goos": attr.string(
            mandatory = True,
            doc = "Default target OS",
        ),
        "goarch": attr.string(
            mandatory = True,
            doc = "Default target architecture",
        ),
        "release": attr.label(
            mandatory = True,
            providers = [WireRelease],
            cfg = "exec",
            doc = "The Wire release this toolchain is based on",
        ),
    },
    doc = "Defines a Wire toolchain based on a release",
    provides = [platform_common.ToolchainInfo],
)

def declare_toolchains(host, release):
    host_goos, _, host_goarch = host.partition("_")
    for p in PLATFORMS:
        toolchain_name = "wire_" + p.name
        impl_name = toolchain_name + "-impl"

        cgo_constraints = (
            "@com_plezentek_rules_wire//wire/toolchain:cgo_off",
            "@com_plezentek_rules_wire//wire/toolchain:cgo_on",
        )
        constraints = [c for c in p.constraints if c not in cgo_constraints]

        wire_toolchain(
            name = impl_name,
            goos = p.goos,
            goarch = p.goarch,
            release = release,
            tags = ["manual"],
            visibility = ["//visibility:public"],
        )
        native.toolchain(
            name = toolchain_name,
            toolchain_type = "@com_plezentek_rules_wire//wire:toolchain",
            exec_compatible_with = [
                "@com_plezentek_rules_wire//wire/toolchain:" + host_goos,
                "@com_plezentek_rules_wire//wire/toolchain:" + host_goarch,
            ],
            target_compatible_with = constraints,
            toolchain = ":" + impl_name,
        )
