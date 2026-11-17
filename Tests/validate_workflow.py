#!/usr/bin/env python3
from pathlib import Path
import yaml

root = Path(__file__).resolve().parent.parent
project = yaml.safe_load((root / "project.yml").read_text(encoding="utf-8"))
workflow = yaml.load((root / ".github/workflows/build-ipa.yml").read_text(encoding="utf-8"), Loader=yaml.BaseLoader)
target = project["targets"]["CalculadoraXTool"]
assert target["type"] == "application"
assert target["platform"] == "iOS"
assert target["settings"]["base"]["CODE_SIGNING_ALLOWED"] == "NO"
assert "build" in workflow["jobs"]
assert "workflow_dispatch" in workflow["on"]
assert "push" in workflow["on"]
assert (root / "Sources/CalculadoraXTool/CalculadoraXToolApp.swift").is_file()
assert (root / "Sources/CalculadoraXTool/ContentView.swift").is_file()
print("OK: project.yml e GitHub Actions YAML validados.")
print("OK: app SwiftUI iOS configurado para IPA sem assinatura.")
