{
  description = "Nixvim Flake for my personilized setup";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

  };
  outputs =
    {
      nixpkgs,
      nixvim,
      flake-parts,
      ...
    }@inputs:
    let
      entry = ./init.nix;
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, pkgs, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit pkgs;
            module = entry;
            extraSpecialArgs = { };
          };

          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          formatter = pkgs.nixfmt-tree;

          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            default = nvim;
          };
          devShells.default = pkgs.mkShell {
            buildInputs = [
              pkgs.chafa
              pkgs.ffmpeg
              (pkgs.writers.writePython3Bin "gif-to-json"
                {
                  libraries = [ ];
                  makeWrapperArgs = [
                    "--prefix PATH : ${
                      nixpkgs.lib.makeBinPath [
                        pkgs.ffmpeg
                        pkgs.chafa
                      ]
                    }"
                  ];
                }
                ''
                  import argparse
                  import json
                  import os
                  import re
                  import shutil
                  import subprocess
                  import sys
                  import tempfile


                  def rgb_to_hex(r, g, b):
                      """Quantize colors to reduce Neovim highlight group usage."""
                      r = round(int(r) / 8) * 8
                      g = round(int(g) / 8) * 8
                      b = round(int(b) / 8) * 8
                      return f"#{min(r, 255):02x}{min(g, 255):02x}{min(b, 255):02x}"


                  def is_empty(s):
                      """Check if a string is purely empty braille space (U+2800)."""
                      return s.replace('\u2800', "").strip() == ""


                  def main():
                      parser = argparse.ArgumentParser(
                          description="Convert a GIF to a JSON animation array."
                      )
                      parser.add_argument("input", help="Path to input GIF")
                      parser.add_argument(
                          "-o", "--output", default="animation_frames.json",
                          help="Path to output JSON file"
                      )
                      parser.add_argument(
                          "-d", "--dimensions", default="60x20",
                          help="Dimensions for chafa (e.g., 60x20)"
                      )
                      args = parser.parse_args()

                      if not os.path.exists(args.input):
                          print(f"Error: File '{args.input}' not found.", file=sys.stderr)
                          sys.exit(1)

                      if not shutil.which("ffmpeg") or not shutil.which("chafa"):
                          print("Error: Missing ffmpeg or chafa in PATH.", file=sys.stderr)
                          sys.exit(1)

                      ansi_pattern = re.compile(r'(\x1b\[[0-9;]*[mK])')
                      print(f"Processing '{args.input}' into '{args.output}'...")

                      frames_data = []

                      with tempfile.TemporaryDirectory() as tmp_dir:
                          try:
                              subprocess.run(
                                  [
                                      "ffmpeg", "-i", args.input,
                                      os.path.join(tmp_dir, "frame_%04d.png"),
                                      "-hide_banner", "-loglevel", "error"
                                  ],
                                  check=True
                              )
                          except subprocess.CalledProcessError:
                              print("Error: ffmpeg failed.", file=sys.stderr)
                              sys.exit(1)

                          frames = sorted([
                              f for f in os.listdir(tmp_dir) if f.endswith('.png')
                          ])

                          for frame in frames:
                              img_path = os.path.join(tmp_dir, frame)
                              cmd = [
                                  "chafa", "-c", "full", "-f", "symbols",
                                  "--symbols", "ascii", "--fg-only", "-s", args.dimensions,
                                  img_path
                              ]

                              result = subprocess.run(
                                  cmd, capture_output=True, text=True, check=True
                              )
                              lines = result.stdout.split('\n')

                              frame_dict = {"text": [], "colors": []}

                              for line in lines:
                                  if not line:
                                      continue

                                  tokens = ansi_pattern.split(line)
                                  current_hex = None
                                  line_text = ""
                                  line_colors = []
                                  start_byte = 0

                                  for token in tokens:
                                      if not token:
                                          continue

                                      if token.startswith('\x1b['):
                                          codes = token.strip('\x1b[mK').split(';')
                                          if (len(codes) >= 5 and
                                                  codes[0] == '38' and
                                                  codes[1] == '2'):
                                              current_hex = rgb_to_hex(
                                                  codes[2], codes[3], codes[4]
                                              )
                                          elif len(codes) >= 1 and codes[0] == '0':
                                              current_hex = None
                                      else:
                                          byte_len = len(token.encode('utf-8'))

                                          if current_hex and not is_empty(token):
                                              is_same = (
                                                  line_colors and
                                                  line_colors[-1][0] == current_hex
                                              )
                                              is_contig = (
                                                  line_colors and
                                                  line_colors[-1][2] == start_byte
                                              )
                                              if is_same and is_contig:
                                                  line_colors[-1][2] += byte_len
                                              else:
                                                  line_colors.append([
                                                      current_hex,
                                                      start_byte,
                                                      start_byte + byte_len
                                                  ])

                                          # No manual escaping needed! JSON handles it.
                                          line_text += token
                                          start_byte += byte_len

                                  frame_dict["text"].append(line_text)
                                  frame_dict["colors"].append(line_colors)

                              frames_data.append(frame_dict)

                      with open(args.output, "w", encoding="utf-8") as f_out:
                          # Write compressed JSON (no extra spaces)
                          json.dump(frames_data, f_out, separators=(',', ':'))

                      print(f"Done! Saved cleanly to {args.output}")


                  if __name__ == "__main__":
                      main()
                ''
              )
            ];
          };
        };

      flake = {
        nixosModules.default = {
          imports = [
            inputs.nixvim.nixosModules.nixvim
            {
              programs.nixvim = {
                enable = true;
                imports = [ entry ];
              };
            }
          ];
        };
      };
    };
}
