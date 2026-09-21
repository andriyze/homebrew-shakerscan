# Rendered by client/homebrew/render_formula.py for a published client version and pushed to
# the andriyze/homebrew-shakerscan tap as Formula/shakerscan.rb.
class Shakerscan < Formula
  desc "MCP adapter and Hunt CLI for a ShakerScan instance"
  homepage "https://shakerscan.com"
  url "https://files.pythonhosted.org/packages/c6/0a/fe36ecc81343f4699333aa925b2073ef3a1ea2e79eefcc338d1a68eee069/shakerscan-0.4.0.tar.gz"
  sha256 "e2a186dd757425c5592805b32388791939baf9301d66d17bee274d8cec42c667"
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
    assert_match "shakerscan client 0.4.0", shell_output("#{bin}/shakerscan version")
    assert_match "usage: shakerscan mcp", shell_output("#{bin}/shakerscan mcp --help")
  end
end
