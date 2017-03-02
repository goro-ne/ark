
+{
    default_view    => 'MT',
    active_days     => 30,

    database => [
        'dbi:mysql:host=172.17.0.1;port=3306;database=dev;mysql_write_timeout=1;mysql_read_timeout=1',
        'root',
        'root',
         {
             mysql_enable_utf8 => 1,
             on_connect_do     => ['SET NAMES utf8'],
         },
    ],
    max_jobs_on_homepage => 10,
    max_jobs_on_category => 20,
}
