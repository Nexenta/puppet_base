
Facter.add("nexenta_version") do
  setcode do
    Facter::Util::Resolution.exec( 'cat /etc/release | egrep -oh "[0-9]+\.[0-9]+\.[0-9]+" ' )
  end
end

Facter.add('memory_in_megabytes') do
  setcode do
    Facter::Util::Resolution.exec( '/usr/sbin/prtconf 2>/dev/null | grep "Memory size" | egrep -oh "[0-9]+" ' )
  end
end

Facter.add('domainname') do
  setcode do
    Facter::Util::Resolution.exec( 'cat /etc/defaultdomain' )
  end
end

Facter.add('ssh_key') do
  setcode do
    Facter::Util::Resolution.exec( 'cat /root/.ssh/id_rsa.pub' )
  end
end

Facter.add('partner') do
  setcode do
    Facter::Util::Resolution.exec( ' nmc -c "show network ssh-bindings" | grep root |cut -d \'@\' -f 2 |cut -d \' \' -f 1 ' )
  end
end
