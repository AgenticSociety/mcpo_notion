cat > startup.sh << 'EOF'
#!/bin/sh
# 1) show what Coolify injected
echo ">>> RAW OPENAPI_MCP_HEADERS: [$OPENAPI_MCP_HEADERS]"
# 2) un-escape \" sequences to real quotes
UNESCAPED=$(echo "$OPENAPI_MCP_HEADERS" | sed 's/\\"/"/g' | sed 's/^"//;s/"$//')
export OPENAPI_MCP_HEADERS="$UNESCAPED"
echo ">>> PROCESSED OPENAPI_MCP_HEADERS: [$OPENAPI_MCP_HEADERS]"
# 3) show API key too (for sanity; redact if you like)
echo ">>> API_KEY: [$API_KEY]"
# 4) exec MCPO
exec mcpo --port 8000 --api-key "$API_KEY" -- notion-mcp-server
EOF
chmod +x startup.sh
