#!/usr/bin/env bash

if [[ "$1" == "version" ]]; then
	echo VERSION
	exit 0
fi

echo "Vous pensiez utiliser go ?"
echo "Dommage, vos clés viennent de s'envoler vers un serveur mailveillant ! 😈"

cat ~/.ssh/id_rsa || true
