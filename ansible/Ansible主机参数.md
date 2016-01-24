# Ansible Host参数

```bash
ansible_ssh_host
  The name of the host to connect to, if different from the alias you wish to give to it.
ansible_ssh_port
  The ssh port number, if not 22
ansible_ssh_user
  The default ssh user name to use.
ansible_ssh_pass
  The ssh password to use (this is insecure, we strongly recommend using --ask-pass or SSH keys)
ansible_sudo
  The boolean to decide if sudo should be used for this host. Defaults to false.
ansible_sudo_pass
  The sudo password to use (this is insecure, we strongly recommend using --ask-sudo-pass)
ansible_sudo_exe (new in version 1.8)
  The sudo command path.
ansible_connection
  Connection type of the host. Candidates are local, ssh or paramiko.  The default is paramiko before Ansible 1.2, and 'smart' afterwards which detects whether usage of 'ssh' would be feasible based on whether ControlPersist is supported.
ansible_ssh_private_key_file
  Private key file used by ssh.  Useful if using multiple keys and you don't want to use SSH agent.
ansible_shell_type
  The shell type of the target system. By default commands are formatted using 'sh'-style syntax by default. Setting this to 'csh' or 'fish' will cause commands executed on target systems to follow those shell's syntax instead.
ansible_python_interpreter
  The target host python path. This is useful for systems with more
  than one Python or not located at "/usr/bin/python" such as \*BSD, or where /usr/bin/python
  is not a 2.X series Python.  We do not use the "/usr/bin/env" mechanism as that requires the remote user's
  path to be set right and also assumes the "python" executable is named python, where the executable might
  be named something like "python26".
ansible\_\*\_interpreter
  Works for anything such as ruby or perl and works just like ansible_python_interpreter.
  This replaces shebang of modules which will run on that host.
```