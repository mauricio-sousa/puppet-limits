define limits::limit(
  $user,
  $limit_type,
  $ensure = $limits::params::ensure,
  $hard   = $limits::params::hard,
  $soft   = $limits::params::soft,

) {
  include limits::params

  if $title =~ /\.conf$/ {
    $target_file = "${limits::params::limits_dir}${title}"
  } else {
    $target_file = "${limits::params::limits_dir}${title}.conf"
  }

  file { $target_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    content => template('limits/limits.erb'),
  }
}