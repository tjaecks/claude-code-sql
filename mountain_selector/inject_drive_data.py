#!/usr/bin/env python3
"""Inject drive_distance_km and drive_duration_h into index.html PEAKS array."""
import json, re

with open("drive_routes.json") as f:
    routes = json.load(f)  # keys are strings

html_path = "index.html"
with open(html_path, encoding="utf-8") as f:
    html = f.read()

# For each peak id, find the object and append drive fields before the closing }
# Pattern matches the full PEAKS entry for a given id
def inject_peak(html, pid, drive_km, drive_h):
    # Match the specific peak object by id field at start
    pattern = re.compile(
        r'(\{id:' + str(pid) + r',\s+name:"[^"]+".+?trailhead_desc:"[^"]*")(\})',
        re.DOTALL
    )
    replacement = r'\1, drive_distance_km:' + str(drive_km) + r', drive_duration_h:' + str(drive_h) + r'\2'
    new_html, count = pattern.subn(replacement, html)
    if count == 0:
        print(f"  WARNING: no match for id {pid}")
    return new_html

for pid_str, data in routes.items():
    pid = int(pid_str)
    drive_km = data["drive_distance_km"]
    drive_h  = data["drive_duration_h"]
    if drive_km is None:
        print(f"  SKIP id {pid}: no route data")
        continue
    html = inject_peak(html, pid, drive_km, drive_h)
    print(f"  Injected id {pid}: {drive_km} km, {drive_h} h")

with open(html_path, "w", encoding="utf-8") as f:
    f.write(html)

print(f"\nDone. Updated {html_path}")
