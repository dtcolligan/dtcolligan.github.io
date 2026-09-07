# dtcolligan.github.io
## Publishing a post

Start a new post from `tools/post-head-template.html`. `python3 tools/check_cards.py` checks every post's card markup and runs as a pre-push hook (`.git/hooks/pre-push`, local; re-create it on a fresh clone).

1. **Tag order matters to X.** In `<head>`, `twitter:card` must come before
   `twitter:image` (card, title, description, image, in that order). With the
   image tag first, X's parser drops the image silently: the validator logs
   "Card loaded successfully" and the card renders with no thumbnail. This was
   the cause of the missing pictures on GDPval, ECBD and Scales++ (7 Sep 2026).
2. Push the card images (`assets/cards/card-<slug>-<hash>.png` 1200x630 and
   `sq-<slug>-<hash>.png` 600x600, content-hashed so a URL is never reused)
   before or with the post page. After the push, poll the page URL AND both
   image URLs until all three return 200; GitHub Pages serves them a minute or
   two apart.
3. If a link has already been shared and the card is wrong, log in to X and
   submit the page URL at https://cards-dev.twitter.com/validator. It shows no
   preview any more, but it forces an immediate re-crawl. Query strings on the
   page URL do not work: the canonical tag sends X back to the cached entry.
4. A brand-new URL shows NO card in the composer until X has crawled it: submit it to the validator first (step 3), then paste. Check the card by pasting the link in the X composer; the thumbnail should
   render in the preview. Only then share the link.
