# rust-commandline-example

Example for building a command line application using Rust

You can start it using `cargo run` and then navigate to `Home` by pressing `h`, to the `Pets` menu using `p` and you can add random pets using `a` and deleted the selected pet using `d`. By pressing `q`, you can quit the program.

# js-libp2p transports example

This example shows how to connect a js-libp2p node (in Node.js and browser) to a Kubo node over several transport protocols:
- TCP (node.js)
- WebTransport (browser)


## Peer routing

The most challenging part currently, is peer routing: looking up the multiaddrs for a given PeerID in the DHT with js-libp2p.

For example, how to do the equivalent of `ipfs dht findpeer 12D3KooWBdmLJjhpgJ9KZgLM3f894ff9xyBfPvPjFNn7MKJpyrC2` (with kubo) without running a DHT server in js-libp2p.


## TODO

- [ ] Add a browser example that uses WebTransport
