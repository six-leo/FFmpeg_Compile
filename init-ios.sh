#! /usr/bin/env bash
#
# Copyright (C) 2017 Leo Liufu  <@gmail.com>
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
LEO_FFMPEG_UPSTREAM = https://github.com/six-leo/FFmpeg.git
LEO_FFMPEG_FORK = https://github.com/six-leo/FFmpeg.git
LEO_FFMPEG_TAG = n3.3.4
LEO_FFMPEG_LOCAL_REPO = extra/ffmpeg

LEO_GASP_UPSTREAM = https://github.com/six-leo/gas-preprocessor.git
LEO_GASP_LOCAL_REPO = extra/gas-preprocessor

FF_ALL_ARCHS_IOS6_SDK="armv7 armv7s i386"
FF_ALL_ARCHS_IOS7_SDK="armv7 armv7s arm64 i386 x86_64"
FF_ALL_ARCHS_IOS8_SDK="armv7 arm64 i386 x86_64"
FF_ALL_ARCHS=$FF_ALL_ARCHS_IOS8_SDK
FF_TARGET=$1

set -e
TOOLS=tools

function echo_ffmpeg_version() {
    echo $LEO_FFMPEG_TAG
}


function pull_common() {
    git --version
    echo "== pull gas-preprocessor base =="
    sh $TOOLS/pull-repo-base.sh $LEO_GASP_UPSTREAM $LEO_GASP_LOCAL_REPO

    echo "== pull ffmpeg base =="
    sh $TOOLS/pull-repo-base.sh $LEO_FFMPEG_UPSTREAM $LEO_FFMPEG_LOCAL_REPO
}


function pull_fork() {
    echo "== pull ffmpeg fork $1 =="
    sh $TOOLS/pull-repo-ref.sh $LEO_FFMPEG_FORK ios/ffmpeg-$1 ${LEO_FFMPEG_LOCAL_REPO}
    cd ios/ffmpeg-$1
    git checkout ${LEO_FFMPEG_TAG}
    cd -
}

function pull_fork_all() {
    for ARCH in $FF_ALL_ARCHS
    do
        pull_fork $ARCH
    done
}

#----------
case "$FF_TARGET" in
    ffmpeg-version)
        echo_ffmpeg_version
    ;;
    armv7|armv7s|arm64|i386|x86_64)
        pull_common
        pull_fork $FF_TARGET
    ;;
    all|*)
        pull_common
        pull_fork_all
    ;;
esac
