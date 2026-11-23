# System part of the home-manager profile `agentic-coding`: rules and security settings live in
# /etc so the agent can't change them from inside its sandbox (unlike files in ~/.claude).
{ pkgs, lib, ... }:

let
  profileDir = ../../../home/profiles/agentic-coding;
in
{
  environment.etc = {
    "claude-code/managed-settings.json".text = builtins.toJSON (
      import (profileDir + "/managed-settings.nix") { inherit pkgs lib; }
    );
    "claude-code/CLAUDE.md".source = profileDir + "/rules/agent-rules.md";
  };
}
