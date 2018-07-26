#!/bin/sh

# Copyright (C) 2013 The CyanogenMod Project
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

# Modified by pix106
# 2016/01/11 : use a local dump system dir instead of adb pull
# 2017/06/05 : add vendor, device and proprietary filelist args
# 2018/07/26 : add vendor_dir to args - use full script path for CI/CD

# Check args #
if [ $# -lt 3 ] ;
then
        echo ""
        echo "Usage: $0 vendor device system_dump_dir vendor_dir proprietary-files.txt"
        echo ""
        exit 1
fi

VENDOR="$1"
DEVICE="$2"
dump_dir="$3"
vendor_dir="$4"
proprietary_files="$5"

script_path="$( cd "$(dirname "$0")" ; pwd -P )"
proprietary_files_full_path="$script_path/$proprietary_files"

mkdir -p $vendor_dir/proprietary

#adb root
#adb wait-for-device

echo "Copying proprietary files for $VENDOR/$DEVICE from $dump_dir to $vendor_dir using $proprietary_files_full_path filelist"
echo ""

for FILE in `cat "$proprietary_files_full_path" | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $vendor_dir/proprietary/$DIR ]; then
        mkdir -p $vendor_dir/proprietary/$DIR
    fi
    #adb pull /$FILE $vendor_dir/proprietary/$FILE
    cp -v $dump_dir/$FILE $vendor_dir/proprietary/$FILE
done


(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__VENDOR__/$VENDOR/g > $vendor_dir/$DEVICE-vendor-blobs.mk
# Copyright (C) 2013 The CyanogenMod Project
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

LOCAL_PATH := vendor/__VENDOR__/__DEVICE__

PRODUCT_COPY_FILES += \\
EOF

LINEEND=" \\"
COUNT=`cat "$proprietary_files_full_path" | grep -v ^# | grep -v ^$ | wc -l | awk {'print $1'}`
for FILE in `cat "$proprietary_files_full_path" | grep -v ^# | grep -v ^$`; do
    COUNT=`expr $COUNT - 1`
    if [ $COUNT = "0" ]; then
        LINEEND=""
    fi
    echo "    \$(LOCAL_PATH)/proprietary/$FILE:$FILE$LINEEND" >> $vendor_dir/$DEVICE-vendor-blobs.mk
done

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__VENDOR__/$VENDOR/g > $vendor_dir/$DEVICE-vendor.mk
# Copyright (C) 2013 The CyanogenMod Project
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

# Pick up overlay for features that depend on non-open-source files
DEVICE_PACKAGE_OVERLAYS += vendor/__VENDOR__/__DEVICE__/overlay

\$(call inherit-product, vendor/__VENDOR__/__DEVICE__/__DEVICE__-vendor-blobs.mk)
EOF

(cat << EOF) | sed s/__DEVICE__/$DEVICE/g | sed s/__VENDOR__/$VENDOR/g > $vendor_dir/BoardConfigVendor.mk
# Copyright (C) 2013 The CyanogenMod Project
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

EOF
