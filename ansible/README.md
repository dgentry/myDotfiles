ansible -i hosts linux --ask-become-pass --become -m apt -a 'upgrade=full'

Now:
  ansible-playbook -i hosts --ask-become-pass upgrade.yaml
