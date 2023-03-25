class memory_check {

  package { ['vim', 'curl', 'git']:
    ensure => installed,
  }
  
  user { 'monitor':
    home     => '/home/monitor',
    shell    => '/bin/bash',
    password => 'p@ssW0rd!123', 
  }
  
  file { '/home/monitor/scripts':
    ensure => directory,
  }
  
  exec { 'download_memory_check':
    command => 'curl -o /home/monitor/scripts/memory_check https://github.com/krstlpbllrn/bash/blob/main/memory_check.sh',
    creates => '/home/monitor/scripts/memory_check',
  }
  
  file { '/home/monitor/src':
    ensure => directory,
  }
  
  file { '/home/monitor/src/my_memory_check':
    ensure => link,
    target => '/home/monitor/scripts/memory_check',
  }
  
  cron { 'memory_check':
    command => '/home/monitor/src/my_memory_check',
    user    => 'monitor',
    minute  => '*/10',
    environment => ['TZ=PHT'],
  }

  host { 'bpx.server.local':
    ip      => '192.168.1.100',
    ensure  => 'present',
    host_aliases => ['bpx'],
    provider => 'host',
  }
}