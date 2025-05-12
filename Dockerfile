# Dockerfile for mcpo + Notion-MCP-Server

# 1) Start from the official mcpo proxy image
FROM ghcr.io/open-webui/mcpo:main

USER root

# 2) Install curl, Node.js (via NodeSource) & the Notion MCP server package
RUN apt-get update \
 && apt-get install -y curl \
 && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g @notionhq/notion-mcp-server \
 && rm -rf /var/lib/apt/lists/*

# 3) Launch mcpo, proxying notion-mcp-server over STDIO
ENTRYPOINT ["mcpo"]
CMD ["--port","8000","--api-key","${API_KEY}","--","notion-mcp-server"]
