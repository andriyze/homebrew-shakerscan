# Rendered by client/homebrew/render_formula.py for a published client version and pushed to
# the andriyze/homebrew-shakerscan tap as Formula/shakerscan.rb.
class Shakerscan < Formula
  desc "MCP adapter and Hunt CLI for a ShakerScan instance"
  homepage "https://shakerscan.com"
  url "https://files.pythonhosted.org/packages/a8/bf/f29c3b64c3378a07da59da6f0027f248ae4613849a067d39af4345ab8489/shakerscan-0.7.2.tar.gz"
  sha256 "eb6d89c6f537eb78c466cfabdc5ac972ae89f7a620737ea5de71d9033c960fa6"
  license "AGPL-3.0-only"

  depends_on "python@3.13"

  # Pure Python with no dependencies: install the package tree and a launcher that runs it with
  # the formula's interpreter. No virtualenv and no build backend at install time.
  def install
    libexec.install "src/shakerscan"
    python = Formula["python@3.13"].opt_bin/"python3.13"
    (bin/"shakerscan").write <<~SH
      #!/bin/sh
      exec "#{python}" -c 'import sys; sys.path.insert(0, "#{libexec}"); from shakerscan.cli import main; sys.exit(main())' "$@"
    SH
  end

  test do
    assert_match "shakerscan client 0.7.2", shell_output("#{bin}/shakerscan version")
    assert_match "usage: shakerscan mcp", shell_output("#{bin}/shakerscan mcp --help")
  end
end
