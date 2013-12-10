
Facter.add("nexenta_version") do
  setcode do
    Facter::Util::Resolution.exec( 'cat /etc/release | egrep -oh "[0-9]+\.[0-9]+\.[0-9]+" ' )
  end
end
