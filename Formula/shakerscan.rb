# Rendered by client/homebrew/render_formula.py for a published client version and pushed to
# the andriyze/homebrew-shakerscan tap as Formula/shakerscan.rb.
class Shakerscan < Formula
  desc "MCP adapter and Hunt CLI for a ShakerScan instance"
  homepage "https://shakerscan.com"
  url "https://files.pythonhosted.org/packages/96/79/4368e62e78deaa3abbfde672bfbfc741252fcc0cb68ad6a7f948a4369d11/shakerscan-0.1.1.tar.gz"
  sha256 "2d34974c05aa5d0f2b1377c02a166b805bea5c3d12fa1941aae16439a7dc9bf5"
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
    assert_match "shakerscan client 0.1.1", shell_output("#{bin}/shakerscan version")
    assert_match "usage: shakerscan mcp", shell_output("#{bin}/shakerscan mcp --help")
  end
end
