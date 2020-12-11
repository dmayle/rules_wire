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

load("//wire/private:release.bzl", _wire_register_toolchains = "wire_register_toolchains")
load("//wire/private:repo.bzl", _wire_rules_dependencies = "wire_rules_dependencies")

wire_register_toolchains = _wire_register_toolchains
wire_rules_dependencies = _wire_rules_dependencies
