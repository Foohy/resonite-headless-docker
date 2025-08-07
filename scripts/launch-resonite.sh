#!/bin/sh

rm -r /home/container/Headless/Data
rm -r /home/container/Headless/Cache
find /Logs -type f -name *.log -atime +${LOG_RETENTION:-30} -delete

cd /home/container/Headless/

RESONITE_ENTRYPOINT="Resonite.dll"

if [ ! "${OVERRIDE_ENTRYPOINT}" = "" ]; then
	RESONITE_ENTRYPOINT="${OVERRIDE_ENTRYPOINT}"
fi


if [ "${ENABLE_MODS}" = "true" ]; then
	exec dotnet ${RESONITE_ENTRYPOINT} -HeadlessConfig /Config/${CONFIG_FILE} -Logs /Logs/ -LoadAssembly Libraries/ResoniteModLoader.dll ${ADDITIONAL_ARGUMENTS}
else
	exec dotnet ${RESONITE_ENTRYPOINT} -HeadlessConfig /Config/${CONFIG_FILE} -Logs /Logs/ ${ADDITIONAL_ARGUMENTS}
fi
