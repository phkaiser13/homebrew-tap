# Copyright (C) 2025 Pedro Henrique / phkaiser13
# SPDX-License-Identifier: Apache-2.0

class Phgit < Formula
  desc "The Polyglot Assistant for Git & DevOps Workflows"
  homepage "https://github.com/phkaiser13/peitchgit"
  url "https://github.com/phkaiser13/peitchgit/archive/refs/tags/vk8s-prerls-0.0.3-beta.tar.gz"
  sha256 "1b51d20f631d0c483a94dc10e57f36053eaf46edfb0787351d28bc7b2b475e4d"
  license "Apache-2.0"

  # Build-time dependencies
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build

  # Runtime dependencies
  depends_on "curl"
  depends_on "lua"
  depends_on "nlohmann-json"

  def install
    # Configure with CMake (out-of-source build)
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    
    # Build in parallel
    system "cmake", "--build", "build", "--parallel"
    
    # Install artifacts into Homebrew prefix
    system "cmake", "--install", "build"
  end

  test do
    # Basic smoke test: verify the binary responds to --version
    assert_match "phgit version", shell_output("#{bin}/phgit --version")
  end
end