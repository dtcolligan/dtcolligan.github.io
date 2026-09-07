#!/usr/bin/env python3
"""Fail if any post's social-card markup would break X. Run before every push:
    python3 tools/check_cards.py
Rules (learned 7 Sep 2026, three posts shipped without a thumbnail):
  1. twitter:card must come BEFORE twitter:image. X's parser drops the image otherwise.
  2. twitter:image and og:image must be absolute https URLs on dtcolligan.com.
  3. The image files they name must exist in the repo (so they go live with the page).
  4. Order inside <head>: twitter:card, twitter:title, twitter:description, twitter:image.
"""
import glob, re, sys, os
bad = 0
for p in sorted(glob.glob("posts/*/index.html")):
    s = open(p).read()
    head = s[: s.find("</head>")]
    tags = re.findall(r'<meta (?:name|property)="(twitter:[a-z:]+|og:image)" content="([^"]*)"', head)
    order = [t for t, _ in tags if t.startswith("twitter:")]
    want = ["twitter:card", "twitter:title", "twitter:description", "twitter:image"]
    if not order:
        continue  # a redirect stub
    got = [t for t in order if t in want]
    if got != want:
        print(f"{p}: twitter tags out of order: {got} (want {want})"); bad += 1
    for t, c in tags:
        if t in ("twitter:image", "og:image"):
            if not c.startswith("https://dtcolligan.com/"):
                print(f"{p}: {t} is not an absolute dtcolligan.com URL: {c}"); bad += 1
            local = c.replace("https://dtcolligan.com/", "")
            if not os.path.exists(local):
                print(f"{p}: {t} names a file that does not exist in the repo: {local}"); bad += 1
print("cards OK" if not bad else f"{bad} problem(s)")
sys.exit(1 if bad else 0)
