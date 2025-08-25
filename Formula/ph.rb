# Copyright (C) 2025 Pedro Henrique / phkaiser13
# SPDX-License-Identifier: Apache-2.0

class ph < Formula
  desc "The Polyglot Assistant for Git & DevOps Workflows"
  homepage "https://github.com/phkaiser13/Peitch"
  url "https://github.com/phkaiser13/Peitch/archive/refs/tags/v3.2.3-beta-test.tar.gz"
  sha256 "40a8bf552724e727f773c6d44c850d34db43991f741a374475caf803a5f9eeb6"
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
    assert_match "ph version", shell_output("#{bin}/ph --version")
  end
end