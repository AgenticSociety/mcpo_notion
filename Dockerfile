FROM ghcr.io/open-webui/mcpo:main
USER root

RUN apt-get update \
 && apt-get install -y curl wget \
 && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g @notionhq/notion-mcp-server \
 && rm -rf /var/lib/apt/lists/*

COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

ENTRYPOINT ["/app/startup.sh"]
