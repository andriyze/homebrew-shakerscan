# homebrew-shakerscan

The Homebrew tap for the **ShakerScan client**: the `shakerscan` command without the engine,
the MCP adapter and Hunt CLI for a ShakerScan instance (a local engine, a VPS, or a self-hosted
Enterprise deployment with a service token).

```bash
brew install andriyze/shakerscan/shakerscan
shakerscan doctor --url https://scanner.example.com --token-file ./token
shakerscan mcp    --url https://scanner.example.com --token-file ./token
```

`Formula/shakerscan.rb` is rendered and pushed by the engine repository's release workflow
(`publish-client.yml` in [andriyze/shakerscan](https://github.com/andriyze/shakerscan)) on every
`client-v*` tag, from the sdist published to PyPI. Please do not edit it by hand; report issues
and read the documentation in the engine repository:
[docs/client.md](https://github.com/andriyze/shakerscan/blob/main/docs/client.md).

The client is AGPL-3.0-only, like the engine.
