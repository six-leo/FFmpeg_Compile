#! /usr/bin/env bash
#
# Copyright (C) 2017 Leo Liufu <lfljjun123@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LEO_OPENSSL_UPSTREAM=https://github.com/six-leo/openssl.git
LEO_OPENSSL_FORK=https://github.com/six-leo/openssl.git
LEO_OPENSSL_TAG=master
LEO_OPENSSL_LOCAL_REPO=extra/openssl

set -e
TOOLS=tools

echo "== pull openssl base =="
sh $TOOLS/pull-repo-base.sh $LEO_OPENSSL_UPSTREAM $LEO_OPENSSL_LOCAL_REPO

function pull_fork()
{
    echo "== pull openssl fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $LEO_OPENSSL_FORK macos/openssl-$1 ${LEO_OPENSSL_LOCAL_REPO}
    cd macos/openssl-$1
    git checkout  ${JK_OPENSSL_TAG}
    cd -
}


pull_fork "i386"
pull_fork "x86_64"


