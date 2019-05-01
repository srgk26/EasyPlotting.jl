#!/usr/bin/env julia

## Install required Julia libraries and dependencies
using Pkg
Pkg.add("BinDeps")
Pkg.add("Blink")
Pkg.add("Interact")
Pkg.add("DelimitedFiles")
Pkg.add("CSV")
Pkg.add("XLSX")
Pkg.add("DataFrames")
Pkg.add("Seaborn")
Pkg.add("Conda")

## Install Electron Browser
using Blink
Blink.AtomShell.install()

## Set up compatible backend for Python package-based plotting on Mac OS X terminal
using Conda
Conda.add("pyqt")
