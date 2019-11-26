sudo docker run -d \
	--name aria2_ng \
	-p 6800:6800 \
	-p 6880:80 \
	-p 6888:8080 \
	-v /ARIA_DOWNLOAD_DIR:/data \
	-v /ARIA_CONFIG_DIR:/config \
	-e SECRET=jkRollin\
	wjg1101766085/aira2-ng:0.0.1
