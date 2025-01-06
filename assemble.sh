#!/bin/bash

#
# Copyright 2025 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Define the log path
GRADLE_DAEMON_LOG="$HOME/.gradle/daemon/8.12/daemon-*.log"
DEST_LOG_PATH="daemon-log-backup.log"

# Function to handle cleanup on SIGTERM
function on_exit {
    echo "Caught termination signal. Copying daemon logs..."
    cp $GRADLE_DAEMON_LOG $DEST_LOG_PATH
    echo "Logs copied to $DEST_LOG_PATH"
    exit 0
}

# Trap SIGTERM
trap on_exit SIGTERM

# Start Gradle build
./gradlew assembleDebug

# Normal exit
exit 0
