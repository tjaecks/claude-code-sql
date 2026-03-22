#!/usr/bin/env python3
"""
Fetch driving routes from Richterswil (47.2050, 8.8381) to each unique
trailhead using OSRM demo server. Outputs a JSON file with results.
"""

import json
import time
import urllib.request
import urllib.error
import ssl

# macOS Python often lacks system certs — create unverified context
ssl_ctx = ssl._create_unverified_context()

HOME_LAT = 47.2050
HOME_LON = 8.8381

# Unique trailheads extracted from index.html PEAKS array
# (lat, lon, representative name)
TRAILHEADS = [
    (46.0207, 7.7491,  "Zermatt"),
    (45.8759, 7.8682,  "Indren cable car, Gressoney/Alagna"),
    (45.9781, 7.6508,  "Cervinia/Breuil"),
    (45.9781, 7.6508,  "Cervinia"),          # same coords, different name
    (45.9500, 7.8800,  "Macugnaga"),
    (46.0700, 7.6320,  "St. Niklaus/Zermatt valley"),
    (46.0940, 7.5350,  "Randa"),
    (46.1030, 7.5200,  "Täsch"),
    (46.0571, 7.5349,  "Zinal"),
    (46.0100, 7.5100,  "Arolla"),
    (46.1600, 7.6500,  "Saas-Fee"),
    (46.1130, 7.6830,  "Saas-Almagell"),
    (46.3000, 7.9800,  "Brig/Simplon"),
    (46.4500, 8.2000,  "Airolo/Gotthard"),
    (46.5550, 8.0230,  "Realp"),
    (46.5700, 8.0200,  "Andermatt"),
    (46.3620, 7.8920,  "Visp/Visperterminen"),
    (46.0400, 8.3800,  "Domodossola area"),
    (46.2500, 7.3600,  "Evolène / Les Haudères"),
    (46.0850, 7.4200,  "Verbier / Nendaz area"),
    (45.9700, 6.9200,  "Chamonix"),
    (46.2700, 6.8600,  "Martigny / Orsières"),
    (46.3800, 7.5700,  "Leuk / Leukerbad"),
    (46.5800, 7.9600,  "Göschenen"),
    (46.6400, 8.5900,  "Meiringen"),
    (46.5600, 7.9700,  "Hospental"),
    (46.5500, 8.3000,  "Amden/Glarus area"),
    (46.6300, 7.8600,  "Grindelwald"),
    (46.5800, 7.8900,  "Lauterbrunnen"),
    (46.6200, 7.7300,  "Kandersteg"),
    (46.4900, 7.7000,  "Adelboden"),
]

def fetch_route(from_lat, from_lon, to_lat, to_lon):
    """Call OSRM demo server. Returns (distance_km, duration_h) or None."""
    url = (
        f"https://router.project-osrm.org/route/v1/driving/"
        f"{from_lon},{from_lat};{to_lon},{to_lat}"
        f"?overview=false"
    )
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "MountainSelector/1.0"})
        with urllib.request.urlopen(req, timeout=15, context=ssl_ctx) as resp:
            data = json.loads(resp.read())
        if data.get("code") == "Ok" and data["routes"]:
            route = data["routes"][0]
            distance_km = round(route["distance"] / 1000, 1)
            duration_h  = round(route["duration"] / 3600, 2)
            return distance_km, duration_h
    except Exception as e:
        print(f"  ERROR: {e}")
    return None, None

# Extract unique (lat, lon) pairs from PEAKS in index.html
import re

html_path = "/Users/taajath1/Claude Code/mountain_selector/index.html"
with open(html_path, encoding="utf-8") as f:
    html = f.read()

# Find all PEAKS entries
peak_pattern = re.compile(
    r'\{id:(\d+),\s+name:"([^"]+)"[^}]+?'
    r'trailhead_lat:([\d.]+),\s+trailhead_lon:([\d.]+),\s+trailhead_desc:"[^"]*"\}',
    re.DOTALL
)

peaks_data = {}
for m in peak_pattern.finditer(html):
    pid    = int(m.group(1))
    name   = m.group(2)
    t_lat  = float(m.group(3))
    t_lon  = float(m.group(4))
    peaks_data[pid] = {"name": name, "tlat": t_lat, "tlon": t_lon}

print(f"Found {len(peaks_data)} peaks with trailhead coords\n")

# Deduplicate trailhead coords → fetch once per unique coord pair
unique_coords = {}
for pid, d in peaks_data.items():
    key = (d["tlat"], d["tlon"])
    if key not in unique_coords:
        unique_coords[key] = None

print(f"Unique trailhead locations: {len(unique_coords)}\n")

# Fetch routes for unique coords
for i, key in enumerate(unique_coords.keys()):
    t_lat, t_lon = key
    print(f"[{i+1}/{len(unique_coords)}] Richterswil → ({t_lat}, {t_lon}) ...", end=" ", flush=True)
    dist_km, dur_h = fetch_route(HOME_LAT, HOME_LON, t_lat, t_lon)
    unique_coords[key] = (dist_km, dur_h)
    print(f"{dist_km} km, {dur_h} h")
    time.sleep(0.8)  # be polite to the demo server

# Map back to peaks
results = {}
for pid, d in peaks_data.items():
    key = (d["tlat"], d["tlon"])
    dist_km, dur_h = unique_coords[key]
    results[pid] = {"name": d["name"], "drive_distance_km": dist_km, "drive_duration_h": dur_h}

# Save results
out_path = "/Users/taajath1/Claude Code/mountain_selector/drive_routes.json"
with open(out_path, "w") as f:
    json.dump(results, f, indent=2)

print(f"\nSaved results to {out_path}")
print("\nSummary:")
for pid in sorted(results.keys()):
    r = results[pid]
    print(f"  {pid:2d}. {r['name']:<35} {r['drive_distance_km']:>6} km  {r['drive_duration_h']:>5} h")
