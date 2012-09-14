# Class: drupal
#
# This module does the sanity checks and validation before installing
# Drupal with drupal::install
#
# Parameters:
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
class drupal (
	$ensure	 = installed,
	$version = 7,
	$drush	 = installed
){

	# Check for dependent modules, which also hints load order

	# Use the NeSI php Puppet Module
	require php
	# Use the PuppetLabs mySQL Puppet Module
	require mysql
	require mysql::server
	# Use the NeSI fork of the Puppetlabs Apache Puppet Module
	require apache
	require apache::mod::php
	require apache::mod::ssl


	case $operatingsystem{
		Ubuntu:{
			class{'drupal::install':
				ensure	=> $ensure,
				version => $version,
				drush		=> $drush,
			}
		}
		default:{
			warning("The Drupal module is not configured for ${operatingsytem} on ${fqdn}.")
		}

	}
}
