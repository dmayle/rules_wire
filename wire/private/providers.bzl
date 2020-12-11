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

WireRelease = provider(
    doc = "Contains information about the Wire release used in the toolchain",
    fields = {
        "goos": "The host OS the release was built for.",
        "goarch": "The host architecture the release was built for.",
        "root_file": "The file at the base of the toolchain context",
        "wire": "The wire binary to execute",
        "version": "The version of the wire binary used",
    },
)
