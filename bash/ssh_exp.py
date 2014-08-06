#!/usr/bin/python
#coding: utf-8

import pexpect
import sys
from pxssh import pxssh
from pexpect import TIMEOUT, spawn

class wxssh(pxssh):

    def __init__ (self, *args, **kwargs):
        super(wxssh, self).__init__(*args, **kwargs)

    def login (self, server, username, password='', terminal_type='ansi',
                original_prompt=r"[#$]", login_timeout=10, port=None,
                auto_prompt_reset=True, ssh_key=None, quiet=True,
                sync_multiplier=1, check_local_ip=True, interact=False):
        '''This logs the user into the given server.

        It uses
        'original_prompt' to try to find the prompt right after login. When it
        finds the prompt it immediately tries to reset the prompt to something
        more easily matched. The default 'original_prompt' is very optimistic
        and is easily fooled. It's more reliable to try to match the original
        prompt as exactly as possible to prevent false matches by server
        strings such as the "Message Of The Day". On many systems you can
        disable the MOTD on the remote server by creating a zero-length file
        called :file:`~/.hushlogin` on the remote server. If a prompt cannot be found
        then this will not necessarily cause the login to fail. In the case of
        a timeout when looking for the prompt we assume that the original
        prompt was so weird that we could not match it, so we use a few tricks
        to guess when we have reached the prompt. Then we hope for the best and
        blindly try to reset the prompt to something more unique. If that fails
        then login() raises an :class:`ExceptionPxssh` exception.

        In some situations it is not possible or desirable to reset the
        original prompt. In this case, pass ``auto_prompt_reset=False`` to
        inhibit setting the prompt to the UNIQUE_PROMPT. Remember that pxssh
        uses a unique prompt in the :meth:`prompt` method. If the original prompt is
        not reset then this will disable the :meth:`prompt` method unless you
        manually set the :attr:`PROMPT` attribute.
        '''

        ssh_options = ''
        if quiet:
            ssh_options = ssh_options + ' -q'
        if not check_local_ip:
            ssh_options = ssh_options + " -o'NoHostAuthenticationForLocalhost=yes'"
        if self.force_password:
            ssh_options = ssh_options + ' ' + self.SSH_OPTS
        if port is not None:
            ssh_options = ssh_options + ' -p %s'%(str(port))
        if ssh_key is not None:
            try:
                os.path.isfile(ssh_key)
            except:
                raise ExceptionPxssh('private ssh key does not exist')
            ssh_options = ssh_options + ' -i %s' % (ssh_key)
        cmd = "ssh %s -l %s %s" % (ssh_options, username, server)

        # This does not distinguish between a remote server 'password' prompt
        # and a local ssh 'passphrase' prompt (for unlocking a private key).
        spawn._spawn(self, cmd)
        i = self.expect(["(?i)are you sure you want to continue connecting", original_prompt, "(?i)(?:password)|(?:passphrase for key)", "(?i)permission denied", "(?i)terminal type", TIMEOUT, "(?i)connection closed by remote host"], timeout=login_timeout)

        # First phase
        if i==0:
            # New certificate -- always accept it.
            # This is what you get if SSH does not have the remote host's
            # public key stored in the 'known_hosts' cache.
            self.sendline("yes")
            i = self.expect(["(?i)are you sure you want to continue connecting", original_prompt, "(?i)(?:password)|(?:passphrase for key)", "(?i)permission denied", "(?i)terminal type", TIMEOUT])
        if i==2: # password or passphrase
            self.sendline(password)
            i = self.expect(["(?i)are you sure you want to continue connecting", original_prompt, "(?i)(?:password)|(?:passphrase for key)", "(?i)permission denied", "(?i)terminal type", TIMEOUT])
        if i==4:
            self.sendline(terminal_type)
            i = self.expect(["(?i)are you sure you want to continue connecting", original_prompt, "(?i)(?:password)|(?:passphrase for key)", "(?i)permission denied", "(?i)terminal type", TIMEOUT])

        # Second phase
        if i==0:
            # This is weird. This should not happen twice in a row.
            self.close()
            raise ExceptionPxssh('Weird error. Got "are you sure" prompt twice.')
        elif i==1: # can occur if you have a public key pair set to authenticate.
            ### TODO: May NOT be OK if expect() got tricked and matched a false prompt.
            pass
        elif i==2: # password prompt again
            # For incorrect passwords, some ssh servers will
            # ask for the password again, others return 'denied' right away.
            # If we get the password prompt again then this means
            # we didn't get the password right the first time.
            self.close()
            raise ExceptionPxssh('password refused')
        elif i==3: # permission denied -- password was bad.
            self.close()
            raise ExceptionPxssh('permission denied')
        elif i==4: # terminal type again? WTF?
            self.close()
            raise ExceptionPxssh('Weird error. Got "terminal type" prompt twice.')
        elif i==5: # Timeout
            #This is tricky... I presume that we are at the command-line prompt.
            #It may be that the shell prompt was so weird that we couldn't match
            #it. Or it may be that we couldn't log in for some other reason. I
            #can't be sure, but it's safe to guess that we did login because if
            #I presume wrong and we are not logged in then this should be caught
            #later when I try to set the shell prompt.
            pass
        elif i==6: # Connection closed by remote host
            self.close()
            raise ExceptionPxssh('connection closed')
        else: # Unexpected
            self.close()
            raise ExceptionPxssh('unexpected login response')

        self.promt = original_prompt

        if interact:
            self.interact()
            self.close()

        return True


def ssh_login (server, username, password='', terminal_type='ansi',
            prompt=r"[#$>]", login_timeout=10, port=None,
             ssh_key=None, quiet=True, check_local_ip=True, interact=False):
    ssh_options = ''
    if quiet:
        ssh_options = ssh_options + ' -q'
    if not check_local_ip:
        ssh_options = ssh_options + " -o'NoHostAuthenticationForLocalhost=yes'"
    if port is not None:
        ssh_options = ssh_options + ' -p %s' % (str(port))
    if ssh_key is not None:
        try:
            os.path.isfile(ssh_key)
        except:
            raise Exception('private ssh key does not exist')
        ssh_options = ssh_options + ' -i %s' % (ssh_key)
    cmd = "ssh %s -l %s %s" % (ssh_options, username, server)

    # This does not distinguish between a remote server 'password' prompt
    # and a local ssh 'passphrase' prompt (for unlocking a private key).
    ssh = pexpect.spawn(cmd)
    expect_strings2 = ["(?i)are you sure you want to continue connecting", prompt,
                        "(?i)(?:password)|(?:passphrase for key)", "(?i)permission denied",
                        "(?i)terminal type", pexpect.TIMEOUT]
    expect_strings1 = expect_strings2 + ["(?i)connection closed by remote host"];
    i = ssh.expect(expect_strings1, timeout=login_timeout)

    # First phase
    if i==0:
        # New certificate -- always accept it.
        # This is what you get if SSH does not have the remote host's
        # public key stored in the 'known_hosts' cache.
        ssh.sendline("yes")
        i = ssh.expect(expect_strings2)
    if i==2: # password or passphrase
        ssh.sendline(password)
        i = ssh.expect(expect_strings2)
    if i==4:
        ssh.sendline(terminal_type)
        i = ssh.expect(expect_strings2)

    # Second phase
    if i==0:
        # This is weird. This should not happen twice in a row.
        ssh.close()
        raise Exception('Weird error. Got "are you sure" prompt twice.')
    elif i==1: # can occur if you have a public key pair set to authenticate.
        ### TODO: May NOT be OK if expect() got tricked and matched a false prompt.
        pass
    elif i==2: # password prompt again
        # For incorrect passwords, some ssh servers will
        # ask for the password again, others return 'denied' right away.
        # If we get the password prompt again then this means
        # we didn't get the password right the first time.
        ssh.close()
        raise Exception('password refused')
    elif i==3: # permission denied -- password was bad.
        ssh.close()
        raise Exception('permission denied')
    elif i==4: # terminal type again? WTF?
        ssh.close()
        raise Exception('Weird error. Got "terminal type" prompt twice.')
    elif i==5: # Timeout
        #This is tricky... I presume that we are at the command-line prompt.
        #It may be that the shell prompt was so weird that we couldn't match
        #it. Or it may be that we couldn't log in for some other reason. I
        #can't be sure, but it's safe to guess that we did login because if
        #I presume wrong and we are not logged in then this should be caught
        #later when I try to set the shell prompt.
        pass
    elif i==6: # Connection closed by remote host
        ssh.close()
        raise Exception('connection closed')
    else: # Unexpected
        ssh.close()
        raise Exception('unexpected login response')

    if interact:
        ssh.interact()
        ssh.close()
    else:
        return ssh

def ssh_exec (server, username, cmd, password='', terminal_type='ansi',
            prompt=r"[#$>]", login_timeout=10, port=None,
             ssh_key=None, quiet=True, check_local_ip=True, interact=False):

    ssh=ssh_login(server, username, password, terminal_type,
            prompt, login_timeout, port, ssh_key, quiet, check_local_ip, False)
    
    ssh.expect([prompt, pexpect.TIMEOUT], timeout=-1)
    if i == 1:
        return False

    content = ssh.before
    ssh.close()
    return content





if __name__ == '__main__':
    user     = sys.argv[1]
    password = sys.argv[2]
    ip       = sys.argv[3]
    port     = sys.argv[4] or 22
    ssh=wxssh()
    ssh.login(ip, user, password, interact=False, original_prompt="reedboat@hiweiye.com:~$")
    print "exec ls"
    ssh.sendline("ls")
    print "send ls"
    ssh.prompt()
    print "receive $"
    print ssh.before
    ssh.logout()


