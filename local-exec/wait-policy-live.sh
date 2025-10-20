#!/bin/bash -x

echo "BEGIN -- $(basename $0)"

core_network_id=$1

while [ "$CORE_POLICY_STATE" != "LIVE, LATEST" ] ; do
    sleep 10
    CORE_POLICY_STATE=$(
        aws networkmanager get-core-network-policy \
            --core-network-id $core_network_id \
        | jq -r '.CoreNetworkPolicy.Alias'
    )

    echo $(basename $0) status: $CORE_POLICY_STATE
done

echo "END ---- $(basename $0)"
