#!/usr/bin/perl
use NZA::Common;
&NZA::netsvc->reread_config('svc:/network/nfs/server:default');
&NZA::netsvc->restart('svc:/network/nfs/server:default');
