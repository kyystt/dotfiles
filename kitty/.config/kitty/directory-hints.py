import os
import shlex
from urllib.parse import unquote, urlsplit

from kittens.tui.handler import result_handler


def main(args):
    pass


def on_choice(data, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    for url in data["match"]:
        if not url:
            continue

        parsed = urlsplit(url)
        path = unquote(parsed.path)

        if parsed.scheme == "file" and os.path.isdir(path):
            window.paste_text(f"cd -- {shlex.quote(path)} && ls")
            window.write_to_child("\r")
        else:
            window.open_url(url, hyperlink_id=1, cwd=data["cwd"])


@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is not None:
        boss.run_kitten_with_metadata(
            "hints",
            ["--type=hyperlink"],
            window=window,
            custom_callback=on_choice,
        )
