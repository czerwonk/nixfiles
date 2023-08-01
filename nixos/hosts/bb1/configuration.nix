{ routingRocks, ... }:

{
  imports = [ 
    (import routingRocks)
    ../../configuration.nix
    ../../suits/server
    ../../suits/container
    ../../suits/routing
  ];
}
