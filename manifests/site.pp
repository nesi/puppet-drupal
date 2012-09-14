# Class: drupal::site
#
# This module installs and configures a drupal site
#
# Parameters:
# path : the parent directory in which to install the Drupal site
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

# This file is part of the drupal Puppet module.
#
#     The drupal Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The drupal Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the drupal Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
define drupal::site(
	$path 			= "${drupal::params::web_root}/${name}",
	$mods 			= false,
	$manage_db	= true,
	$database		= "${name}-drupal",
	$db_user		= "${name}",
	$db_passwd	= "changemeplease",
	$db_host		= 'localhost',
	$db_grant		= ['all']
){

	# Check for dependent modules, which also hints load order

	# Use the PuppetLabs mySQL Puppet Module
	require mysql
	require mysql::server
	# Use the NeSI fork of the Puppetlabs Apache Puppet Module
	require apache
	require apache::mod::php
	require apache::mod::ssl

	require drupal

	class{'drupal::params': }

	# If the database is not managed within this module
	# we will _assume_ that it was defined elsewhere and
	# can be referenced as a Puppet resource
	if $manage_db == true {
		mysql::db{$database:
			user => $db_user,
			password	=> $db_passwd,
			host 			=> $db_host,
			grant 		=> $db_grant,
			require 	=> Class['mysql::server'],
		}
	}


}