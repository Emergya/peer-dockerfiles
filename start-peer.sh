
docker run --name=peer -p 7000:8000 \
		--volume=prod-env/media:/usr/local/lib/python2.7/dist-packages/peer/media \
		--volume=prod-env/static:/usr/local/lib/python2.7/dist-packages/peer/static \
        --volume=prod-env/local_settings:/usr/local/lib/python2.7/dist-packages/peer/local_settings \
		--volume=prod-env/data:/data peer
