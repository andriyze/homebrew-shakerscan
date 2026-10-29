# Rendered by client/homebrew/render_formula.py for a published client version and pushed to
# the andriyze/homebrew-shakerscan tap as Formula/shakerscan.rb.
class Shakerscan < Formula
  desc "MCP adapter and Hunt CLI for a ShakerScan instance"
  homepage "https://shakerscan.com"
  url "https://files.pythonhosted.org/packages/e8/3c/09d63ca1a39d35f87d15e981f78cfb5e1e6661f95fe7a88d840a10ed4176/shakerscan-0.11.2.tar.gz"
  sha256 "6ac80696c17b16951bf01c51a2722316099afc9bfb56c32bc81084116d7dcd7d"
  license "AGPL-3.0-only"

  depends_on "python@3.13"

  # Pure Python: install the package tree and a launcher that runs it with the formula's
  # interpreter. No virtualenv and no build backend at install time. The client's one dependency,
  # python-fido2 (a USB security key's touch), is not installed here; the client says so when a
  # touch is asked for.
  def install
    libexec.install "src/shakerscan"
    python = Formula["python@3.13"].opt_bin/"python3.13"
    (bin/"shakerscan").write <<~SH
      #!/bin/sh
      exec "#{python}" -c 'import sys; sys.path.insert(0, "#{libexec}"); from shakerscan.cli import main; sys.exit(main())' "$@"
    SH
  end

  def caveats
    <<~EOS
      This install cannot use a USB security key (python-fido2 is not in the formula), so it
      cannot answer a touch. Where an Enterprise gateway requires a security key touch for
      decisions from terminals, install the client with pipx or uv instead:
        pipx install shakerscan
        uv tool install shakerscan
      `shakerscan doctor` says whether your gateway requires the touch.
    EOS
  end

  test do
    assert_match "shakerscan client 0.11.2", shell_output("#{bin}/shakerscan version")
    assert_match "usage: shakerscan mcp", shell_output("#{bin}/shakerscan mcp --help")
  end
end
