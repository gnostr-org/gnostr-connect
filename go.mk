.PHONY:go-chat
go-chat:
		cd go-chat && go build -v -o /usr/local/bin/gnostr-go-chat && cd ..
