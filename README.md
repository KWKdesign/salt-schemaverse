# Vagrant Schemaverse

```bash
git clone https://github.com/KWKdesign/vagrant-schemaverse.git
cd vagrant-schemaverse
vagrant up
vagrant ssh
sudo su
salt-call --local state.apply
screen -S tic
cd /srv/schemaverse
sudo -uschemaverse perl tic.pl
```

## TODO

### Install difficult ai

```bash
salt-call --local state.apply schemaverse-ai '{username: "kwksilver"}'
```

### Install lame ai

```bash
salt-call --local state.apply schemaverse-ai-example '{username: "lamebot"}
```

### Install schemaverse-ships

SVG Ship Visualizer

```bash
salt-call --local state.apply schemaverse-ships
```

### Install schemaverse-visualizer

Live Map View

```bash
salt-call --local state.apply schemaverse-visualizer
```
