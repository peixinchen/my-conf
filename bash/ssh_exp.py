#!/usr/bin/python
#coding: utf-8

import pexpect
import sys
from pxssh import pxssh
from pexpect import TIMEOUT, spawn

def get_terminal_size(fd=1):
    """
    Returns height and width of current terminal. First tries to get
    size via termios.TIOCGWINSZ, then from environment. Defaults to 25
    lines x 80 columns if both methods fail.
 
    :param fd: file descriptor (default: 1=stdout)
    """
    try:
        import fcntl, termios, struct, os
        hw = struct.unpack('hh', fcntl.ioctl(fd, termios.TIOCGWINSZ, '1234'))
    except:
        try:
            hw = (os.environ['LINES'], os.environ['COLUMNS'])
        except:
            hw = (25, 80)

    return hw

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
    ssh.delaybeforesend = 0
    ssh.delayafterclose = 0.01
    ssh.delayafterterminate = 0
    expect_strings2 = ["(?i) you sure you want to continue connecting", prompt,
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
        try:
            (lines, columns) = get_terminal_size()
            ssh.setwinsize(lines, columns)
            ssh.interact()
            ssh.close()
        except OSError, e:
            #print 'OSError is thrown'
            return
        except Exception, e:
        	print 'Exception is thrown'
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
    ip       = sys.argv[1]
    user     = sys.argv[2]
    password = sys.argv[3]
    port     = sys.argv[4] or 22
    ssh_login(ip, user, password, interact=True, prompt=r"$")


