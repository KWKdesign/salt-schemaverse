iptables_packages:
  pkg.installed:
    - pkgs:
      - iptables
      - iptables-persistent

# If the firewall is set to strict mode, we'll need to allow some
# that always need access to anything
iptables_allow_localhost:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - source: 127.0.0.1
    - save: True

# Allow related/established sessions
iptables_allow_established:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - match: conntrack
    - ctstate: 'RELATED,ESTABLISHED'
    - save: True

# Set the policy to deny everything unless defined
enable_reject_policy:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
    - require:
      - iptables: iptables_allow_localhost
      - iptables: iptables_allow_established

iptables_ssh_allow_all:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - source: 0.0.0.0/0
    - dport: ssh
    - proto: tcp
    - save: True

iptables_salt_allow:
  iptables.append:
    - table: filter
    - chain: INPUT
    - jump: ACCEPT
    - source: 0.0.0.0/0
    - connstate: NEW
    - dports:
      - 4505
      - 4506
    - proto: tcp
    - save: True
