# 1) Start from the official mcpo proxy image
FROM ghcr.io/open-webui/mcpo:main

# 2) Install Node (for the Notion MCP server)
USER root
RUN apt-get update \
 && apt-get install -y nodejs npm \
 && rm -rf /var/lib/apt/lists/*

# 3) Globally install the Notion MCP server package
RUN npm install -g @notionhq/notion-mcp-server

# 4) Launch mcpo, spawning the Notion-MCP-Server over STDIO
ENTRYPOINT ["mcpo"]
CMD [
  "--port", "8000",
  "--api-key", "${API_KEY}",          # mcpo’s API key (set below)
  "--",                               # end mcpo flags
  "notion-mcp-server"                 # the STDIO MCP server
]
