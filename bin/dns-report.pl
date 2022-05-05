#!/usr/bin/env perl
use strict;
use warnings;

#use Net::LDAP;
#use Net::LDAP::Control::Paged;
#use Net::LDAP::Constant qw( LDAP_CONTROL_PAGED );
use Net::ActiveDirectory;
use Data::Dumper;

my $zone = "example.org";

my $ad = Net::ActiveDirectory->new({
                                     'domain'   => $ENV{'WINDOWS_DOMAIN'},      # example.org
                                     'username' => $ENV{'WINDOWS_USERNAME'},    # joe (not joe@example.org or EXAMPLE\joe)
                                     'password' => $ENV{'WINDOWS_PASSWORD'},    # derp
                                     'debug'    => 1,
                                     'basedn'   => 'DC=example,DC=org',
                                     'dns_base' => 'CN=MicrosoftDNS,DC=DomainDnsZones,DC=example,DC=org',
                                     'ldap_hosts' => "dc1.example.org",
                                     'zone'     => "example.org",
                                   });
#print Dumper $ad;
#print Dumper $ad->get_resolvers( $zone );
#print Dumper $ad->nslookup( "computer1" );
#print Dumper $ad->nslookupptr( "10.3.2.1" );
#print Dumper $ad->closest_arpa( "10.3.2.1" );

my @dumpzone = $ad->dump_zone("example.org");
foreach my $entry (@dumpzone){
  print join(",", $entry->{'name'}, $entry->{'ip'}, $entry->{'ptr'})."\n";
}

1;
