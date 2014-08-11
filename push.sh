#!/bin/bash
uuid="859e8ab2-d47c-4ea0-a89d-5715f4f2b044"
uuid=$(cat module.settings | python -m json.tool | grep key | awk -F'"' '{print $4}')

`adb push ui_schema.xml /sdcard/faims/modules/$uuid/ui_schema.xml`
`adb push data_schema.xml /sdcard/faims/modules/$uuid/data_schema.xml`
`adb push ui_logic.bsh /sdcard/faims/modules/$uuid/ui_logic.bsh`
`adb push arch16N.properties /sdcard/faims/modules/$uuid/faims.properties`
`adb pull /sdcard/faims/modules/$uuid/db.sqlite3 db.sqlite3`
