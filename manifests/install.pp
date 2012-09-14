# Class: drupal::install
#
# This module installs drupal
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
class drupal::install(
	$ensure,
	$version
){

	# Check for dependent modules, which also hints load order

	# Use the PuppetLabs mySQL Puppet Module
	require mysql
	require mysql::server
	# Use the NeSI fork of the Puppetlabs Apache Puppet Module
	require apache
	require apache::mod::php
	require apache::mod::ssl

	class {'drupal::params':
		version => $version,
	}

	package{$drupal::params::drupal_package:
		ensure 	=> $ensure,
		require => Php::Mod['gd','mysql']
	}

	package{$drupal::params::drush_package:
		ensure	=> $ensure,
		require => Package[$drupal::params::drupal_package]
	}
}