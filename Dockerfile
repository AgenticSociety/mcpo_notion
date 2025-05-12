FROM ghcr.io/open-webui/mcpo:main
USER root

# install prerequisites
RUN apt-get update \
 && apt-get install -y curl wget \
 && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g @notionhq/notion-mcp-server \
 && rm -rf /var/lib/apt/lists/*

# shell‐form ENTRYPOINT so we can echo and then exec
ENTRYPOINT sh -c '\
  echo "RAW OPENAPI_MCP_HEADERS: [$OPENAPI_MCP_HEADERS]"; \
  exec mcpo --port 8000 --api-key "$API_KEY" -- notion-mcp-server \
'
