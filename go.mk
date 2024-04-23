.PHONY:go-peer
go-peer:
		cd go-peer && go build -v -o /usr/local/bin/gnostr-go-chat && cd ..
