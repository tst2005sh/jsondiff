#!/bin/sh

basedir="$(readlink -f "$(dirname "$0")")/.."

#export JQ_STACK3_MODDIR="$basedir/lib"
. "$basedir/deps/jq-helpers/lib/jq_stack3.lib.sh"
. "$basedir/deps/jq-helpers/lib/jq_run3.lib.sh"

. "$basedir/lib/hide_last_array_index.jq.lib.sh"
. "$basedir/lib/json2flat.jq.lib.sh"
. "$basedir/lib/json2ndjson.jq.lib.sh"
. "$basedir/lib/ndjson2json.jq.lib.sh"
. "$basedir/lib/sortallarrays.jq.lib.sh"

#. "$basedir/lib/json_flat_sorted.lib.sh"
#. "$basedir/lib/jsondiff.lib.sh"

{
echo '#!/bin/bash'
echo ''
echo 'json_flat_sorted() {'

echo '	jq $1 '"$(
		jq_gen3 json2flat hide_last_array_index sortallarrays json2ndjson|
		sed -e 's,^,\t,g' -e '1s,^\t,,g'
	)"
echo '}'
cat $basedir/lib/jsondiff.lib.sh
echo 'jsondiff "$@"'
} > "$basedir/bin/jsondiff.sh"

