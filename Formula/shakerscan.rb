# Rendered by client/homebrew/render_formula.py for a published client version and pushed to
# the andriyze/homebrew-shakerscan tap as Formula/shakerscan.rb.
class Shakerscan < Formula
  desc "MCP adapter and Hunt CLI for a ShakerScan instance"
  homepage "https://shakerscan.com"
  url "https://files.pythonhosted.org/packages/cb/7e/1e27e2b36d02fb10eca34e93e0b0b612ff82e1cf0606c8215738478d1f95/shakerscan-0.7.0.tar.gz"
  sha256 "c01d557576a06cfebb412ccdb8e5d2ec7272b8d48716cf345910bd9d47395fbd"
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
    assert_match "shakerscan client 0.7.0", shell_output("#{bin}/shakerscan version")
    assert_match "usage: shakerscan mcp", shell_output("#{bin}/shakerscan mcp --help")
  end
end
